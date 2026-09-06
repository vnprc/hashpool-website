# hashpool.dev

Content and publishing for <https://hashpool.dev>. A Zola site; everything below
the horizontal rule is the upstream theme's own README.

## Publishing

    allod site deploy --dry-run   # what would change, changing nothing
    allod site deploy             # publish

It builds this repository's default flake package and syncs that store path to
the shared-hosting docroot, deleting server files that are no longer part of the
site. Removals move to `deploy-trash/` on the server rather than being
destroyed, so a mistake is recoverable.

There is no lock to bump: the content is this repository, so a commit and a
deploy is the whole cycle.

`site.toml` names the domain and nothing else. The docroot is derived from it,
and there is deliberately no flag or environment variable that can point a
deploy at a different site -- one hosting account owns every domain's docroot on
this host, so a redirected sync would delete a sibling site.

The list of docroot paths that belong to the host rather than to the site lives
in `allod site deploy`, not here. That is the point of the command: `.well-known/`
must survive a deploy because DirectAdmin answers ACME challenges from it, and a
per-repository copy of that rule would eventually be wrong in one repository and
break certificate renewal about sixty days later.

### Setup, once per machine

The account holds every domain, so this is per machine and not per site:

    nix run nixpkgs#rclone -- config

Create a remote named `shared`, type `ftp`, host `nl-sh1.mynymhosting.net`, the
DirectAdmin FTP user, `explicit_tls` on. The password is entered at a prompt, so
it reaches neither argv nor shell history, and it is typed once.

Connect by hostname, never by IP: the server's certificate names
`nl-sh1.mynymhosting.net` and nothing else, so an IP fails TLS verification.

### Adding another site to this account

Give it a `flake.nix` whose default package builds the site, and a `site.toml`
naming its domain. Nothing else.

---

# Zola PaperMod

![](screenshot.png)


A work in progress port of the [hugo-PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme by [@adityatelange](https://github.com/adityatelange) to [Zola](https://www.getzola.org/) 

Due to config changes introduced with Zola 0.19, only Zola 0.19.1 and later are currently supported.

Demo @ https://cydave.github.io/zola-theme-papermod/


## Features

+ [x] Blog post archive
+ [x] Blog post RSS feeds
+ [x] Tags
+ [x] Tag-based RSS feeds
+ [x] Optional: Custom taxonomies
+ [x] Light / Dark theme switching (with configurable default preference)
+ [x] Syntax highlighting for code snippets (Zola's built-in syntax highlighting)
+ [x] Custom navigation
+ [ ] 3 Modes:
    + [ ] Regular Mode
    + [ ] Home-Info Mode
    + [ ] Profile Mode
+ [x] Code copy buttons
+ [x] Search page
+ [ ] SEO Metadata
+ [ ] Language switcher (multi-language support)


## Installation

1. Download the Theme

```
git submodule add https://github.com/cydave/zola-theme-papermod themes/papermod
```

2. Add `theme = "papermod"` to your zola `config.toml`
3. Copy over the example content to get started

```
cp -r themes/papermod/content content
```


## Options

Papermod customizations exist under a designated `extra.papermod` section.
Refer to [config.toml](config.toml) for available options.


## Contributing

If you would like to help out porting hugo-Papermod to Zola feel free to pick
up a feature and start working on it. All help, no matter how small the
contribution is highly appreciated.

## NixOS

This repo uses Zola 0.19.2 to deploy via github pages. On NixOS you need to build Zola 0.19.2 with an older GCC in a nix shell:

```
nix shell \
  nixpkgs#rustc \
  nixpkgs#cargo \
  nixpkgs#pkg-config \
  nixpkgs#openssl \
  nixpkgs#libsass \
  nixpkgs#gcc13 \
  -c bash
```

Inside that shell build Zola 0.19.2:

```
export CC=gcc
export CXX=g++
cargo install --locked \
  --git https://github.com/getzola/zola \
  --tag v0.19.2 \
  --root ~/.local \
  --force
```

Verify the build worked with `~/.local/bin/zola --version`. Run the hashpool website with `~/.local/bin/zola serve`.
