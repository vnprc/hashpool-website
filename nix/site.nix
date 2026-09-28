{
  runCommand,
  zola,
  cacert,
  websiteSrc,
}:

# The published site, as a derivation.  Building rather than running `zola` in
# a working directory buys two things the publish step depends on: the output
# is immutable once built, and its file times are normalised, so rclone's
# size-and-modtime comparison against the server is stable instead of shifting
# on every rebuild.  FTP offers no checksums, so that comparison is all there
# is.
#
# Changing generator touches this file and nothing else.
runCommand "hashpool-site"
  {
    src = websiteSrc;
    nativeBuildInputs = [ zola ];
    # zola 0.23 builds an HTTP client at startup even when load_data is never
    # called; the sandbox's certless build fails with "No CA certificates
    # were loaded from the system" without this.
    SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
  }
  ''
    cp -R --no-preserve=mode "$src"/. .

    # A symlink committed into the source tree survives into the output, and a
    # web server resolves one at request time against the machine it runs on:
    # `leak -> /etc` publishes /etc/passwd from a public web root.  Zola copies
    # `static/` through verbatim, so refuse them here rather than trusting the
    # generator to drop them.
    found=$(find . -type l -printf '%P -> %l\n')
    if [ -n "$found" ]; then
      printf 'Symlink in the site source, which a public web root must not carry:\n%s\n' "$found" >&2
      exit 1
    fi

    zola build --output-dir "$out"
    test -s "$out/index.html"
  ''
