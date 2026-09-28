{
  writeShellScript,
  coreutils,
  live-server,
  rsync,
  watchexec,
  zola,
}:

# What `allod site serve` runs.  Not `zola serve`: this zola serves its reload
# channel on a second port, and the zola that serves it on the page port cannot
# read these templates.  So the zola that publishes the site builds it, which
# also makes the preview the same render a deploy would ship, and live-server
# serves that build and reloads the browser on the one port.
let
  # Building beside the served directory and copying only what differs keeps
  # that directory in place: zola deletes its output directory on every build,
  # and live-server stops seeing changes once the directory it watches is gone.
  build = writeShellScript "preview-build" ''
    ${zola}/bin/zola build --force --output-dir "$PREVIEW_DIR/build" \
      --base-url "http://$ALLOD_PREVIEW_INTERFACE:$ALLOD_PREVIEW_PORT" &&
      ${rsync}/bin/rsync --recursive --checksum --delete \
        "$PREVIEW_DIR/build/" "$PREVIEW_DIR/site/"
  '';
in
writeShellScript "preview" ''
  set -eu
  PREVIEW_DIR=$(${coreutils}/bin/mktemp -d)
  export PREVIEW_DIR
  trap '${coreutils}/bin/rm -rf "$PREVIEW_DIR"' EXIT
  ${build}
  ${watchexec}/bin/watchexec --postpone --on-busy-update queue -- ${build} &
  ${live-server}/bin/live-server \
    --host "$ALLOD_PREVIEW_INTERFACE" --port "$ALLOD_PREVIEW_PORT" "$PREVIEW_DIR/site"
''
