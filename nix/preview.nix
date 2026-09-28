{
  writeShellScript,
  coreutils,
  live-server,
  rsync,
  watchexec,
  zola,
}:

# Not `zola serve`: the pinned zola serves its reload channel on a second port.
let
  # Built aside, then copied: a build that fails empties its output directory.
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
  # TERM is ignored for the removal: a stop signals every process of the unit.
  trap 'trap "" TERM; ${coreutils}/bin/rm -rf "$PREVIEW_DIR"' EXIT
  ${build}
  ${watchexec}/bin/watchexec --postpone --on-busy-update queue -- ${build} &
  ${live-server}/bin/live-server \
    --host "$ALLOD_PREVIEW_INTERFACE" --port "$ALLOD_PREVIEW_PORT" "$PREVIEW_DIR/site"
''
