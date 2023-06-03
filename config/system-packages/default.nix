{ pkgs, lib, unstable, ... }:
let
  codeberg-cli = pkgs.callPackage
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/RobWalt/nixpkgs/cod/pkgs/applications/version-management/codeberg-cli/default.nix";
      sha256 = "sha256:0mhwajbvdwssvmqybq8ws1wpsczixdgycd75gndilzafbgby5d47";
    })
    {
      inherit (pkgs.darwin.apple_sdk.frameworks) Security;
    };
in
{
  environment.systemPackages = with pkgs;
    [
      codeberg-cli

      # apps
      alacritty # terminal
      blender # 3D modelling
      butler # itch.io deploy
      calibre # manage ebooks
      chromium # used for vhs
      cocogitto # gitops
      discord # chat app
      taskwarrior # todo app
      firefox # alternative browser if qutebrowser doesn't work
      flameshot # screenshots
      gimp # image editing
      imagemagick # convert between image data type
      inkscape # drawing tool
      libresprite # pixel art tool
      mdbook # pdf books from markdown
      musescore # musescore
      peek # gif capturing tool
      qutebrowser # broswer with vim controls
      restream # stream remarkable to pc screen
      rustdesk # remote connection to other computers
      spotify # music
      tdesktop # telegram desktop app
      teamspeak_client # voice chat
      thunderbird # email client
      unstable.godot_4 # game engine
      vhs # terminal camera
      unstable.zathura # pdf reader
      zulip # zulip client

      # cli utils
      blueberry # bluetooth config
      bat # better cat
      binutils
      btop # better top
      delta # diffs
      difftastic
      du-dust # better du
      duf
      dunst
      exa
      exercism
      fd
      fzf
      gh
      git
      git-cliff
      git-lfs
      gitoxide
      glab
      hoard
      hurl
      jq
      just
      license-generator
      lsof
      nix-index
      openssl
      pciutils
      ranger
      ripgrep
      sd
      tealdeer
      tokei
      tree
      gum
      unzip
      xdotool # automatically type text
      zip
      zola
      zoxide
      zsh

      xclip # clipboard on x11
      haskellPackages.greenclip # clipboard manager, daemon needs to be started

      # for tmux battery
      acpi
      upower

      # ui
      brightnessctl
      i3lock-fancy

      # stuff
      clang
      lld
      lldb
      killall
      pkg-config
      wget
      wpa_supplicant
      usbutils
      # graph utilities
      graphviz # standard on linux
      xdot # interactive viewer for graphviz

      # audio
      pamixer

      # rust
      rustup
      rust-analyzer
      mold

      # rust cargo extensions
      cargo-audit
      cargo-bloat
      cargo-deny
      cargo-edit
      cargo-expand
      cargo-fuzz
      cargo-generate
      cargo-llvm-lines
      cargo-nextest
      cargo-outdated
      cargo-udeps
      cargo-update
      cargo-watch
      cargo-modules
      cargo-make
      hyperfine
      cargo-hack

      # haskell
      cabal-install
      cabal2nix
      haskellPackages.implicit-hie
      ghc
      haskell-language-server
      ormolu

      # local markdown slides
      jekyll

      # lua
      luajit
      lua-language-server

      # gpg
      pinentry # passphrase input
      gnupg # key signing
      gpgme # key signing
      pass
      rofi-pass

      # wasm
      #unstable.wasm-bindgen-cli # not always up to date
      wasm-pack

      # javascript 
      nodejs

      # docker
      docker-compose

      # for getting ADM GPU Name
      libdrm
    ];
}
