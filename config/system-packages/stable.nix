{ pkgs, ... }:
{
  inherit (pkgs)
    # gui apps
    alacritty# terminal
    blender# 3D modelling
    calibre# manage ebooks
    chromium# used for vhs
    discord# chat app
    firefox# alternative browser if qutebrowser doesn't work
    flameshot# screenshots
    gimp# image editing
    imagemagick# convert between image data type
    inkscape# drawing tool
    libresprite# pixel art tool
    krita# linux image editing
    musescore# musescore
    peek# gif capturing tool
    qutebrowser-qt6# broswer with vim controls
    librewolf# firefox based browser. Switching to it after googles ad DRM proposal
    rustdesk# remote connection to other computers
    spotify# music
    sniffnet# internet traffic viewer
    tdesktop# telegram desktop app
    teamspeak_client# voice chat
    zulip# zulip client
    obsidian# note taking
    jitsi-meet-electron# jitsi desktop app
    # unstable
    #godot_4 # game engine
    zathura# pdf reader

    # cli utils
    # gitoxide  # rusty git

    bat
    binutils
    blueberry# bluetooth config
    btop# better top
    butler# itch.io deploy
    cocogitto# git tooling for conventional commits and other stuff
    colorpicker# colorpicker
    delta# diffs
    difftastic
    du-dust# better du
    duf# shows free space on drives
    dunst# notifications
    exa# better ls
    exercism# exercism cli tool for downloading/submitting
    fd# better find
    fzf# fuzzy finder
    gh# github cli tool
    gcc
    git
    git-cliff
    git-lfs# git large file storage
    glab# gitlab cli tool
    gum# cli scripting glue
    hoard# cli command saver
    hurl# test http requests
    hyperfine# benchmarking in terminal
    jq# json cli processing
    just# make alternative
    libnotify# dependency of dunst
    license-generator# generate standard licenses
    lsof
    mdbook# pdf books from markdown
    mpv# cli media player
    nix-index
    networkmanagerapplet#wifi applet
    openssl# ssh
    pciutils
    rage#simple modern encryption tool using the age format
    ranger# cli file manager
    restream# stream remarkable to pc screen
    ripgrep# better grep
    sd# better sed
    taskwarrior# todo app
    tealdeer# shorter man with examples
    tokei# better loc
    tree# file tree vis
    unzip# zip
    vhs# terminal camera
    xdotool# automatically type text
    zip# zip
    zola# website generation
    zoxide# faster jumping around dirs
    zsh# better bash

    xclip# clipboard on x11

    # for tmux battery
    acpi
    upower

    # ui
    brightnessctl
    i3lock-fancy

    # stuff
    lld
    lldb
    killall
    pkg-config
    wget
    wpa_supplicant
    usbutils

    # graph utilities
    graphviz# standard on linux
    xdot# interactive viewer for graphviz

    # haskell
    cabal-install
    cabal2nix
    ghc
    haskell-language-server
    ormolu

    # audio
    pamixer

    # rust
    clang
    rustup
    mold

    # rust cargo extensions
    # tools
    cargo-audit
    cargo-bloat
    cargo-deny
    cargo-edit
    cargo-expand
    cargo-fuzz
    cargo-generate
    cargo-hack
    cargo-license
    cargo-llvm-lines
    cargo-make
    cargo-modules
    cargo-nextest
    cargo-outdated
    cargo-udeps
    cargo-update
    cargo-watch
    # app specific
    cargo-leptos
    # needs at least v0.19 to work again, currently local install
    diesel-cli


    # local markdown slides
    jekyll

    # lua
    luajit
    lua-language-server

    # wasm
    #unstable.wasm-bindgen-cli # not always up to date
    wasm-pack

    # javascript 
    # nodejs

    # podman 
    podman
    podman-compose
    arion#nix docker-compose
    colmena#nix deployment tool

    # for getting ADM GPU Name
    libdrm;
}
