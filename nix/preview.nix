{
  writeShellScript,
  zola,
}:

writeShellScript "preview" ''
  exec ${zola}/bin/zola serve \
    --interface "$ALLOD_PREVIEW_INTERFACE" --port "$ALLOD_PREVIEW_PORT"
''
