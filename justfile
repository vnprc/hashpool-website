# Publishing.  `just deploy` from anywhere in this repository.
#
# Setup, once per machine and not per site -- the account holds every domain:
#
#   nix run nixpkgs#rclone -- config
#     name:   shared
#     type:   ftp
#     host:   nl-sh1.mynymhosting.net
#     user:   <the DirectAdmin FTP user>
#     pass:   <prompted, stored obscured in ~/.config/rclone/rclone.conf>
#     explicit_tls: true
#
# The password is entered at a prompt, so it reaches neither argv nor shell
# history, and it is typed once ever.

# The only line that differs between sites on this account.
site := "hashpool.dev"

remote := "shared:domains/" + site + "/public_html"

# Build the published site into the Nix store and print its path.
build:
    @nix build --no-link --print-out-paths

# Show what publishing would change, without changing anything.
dry:
    @nix run nixpkgs#rclone -- sync "$(nix build --no-link --print-out-paths)" \
        "{{remote}}" --filter-from deploy.filter --dry-run --verbose

# Publish. Removes server files no longer in the site; removals go to deploy-trash.
deploy:
    @nix run nixpkgs#rclone -- sync "$(nix build --no-link --print-out-paths)" \
        "{{remote}}" --filter-from deploy.filter --verbose \
        --backup-dir "shared:deploy-trash/{{site}}"
    @curl -sS -o /dev/null -w 'https://{{site}}/ -> %{http_code}\n' "https://{{site}}/"
