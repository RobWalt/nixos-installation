{ pkgs, lib, unstable, ... }:
let
  codeberg-cli = pkgs.callPackage
    (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/RobWalt/nixpkgs/cod/pkgs/applications/version-management/codeberg-cli/default.nix";
      sha256 = "sha256:0hl5ckiyjy5y2xpwmvjlnl9rq0rd44pj3f9h3fgplwqzd1mzyw4k";
    })
    {
      inherit (pkgs.darwin.apple_sdk.frameworks) Security;
    };
in
{
  environment.systemPackages = with pkgs;
    [
      # codeberg-cli

      # gui apps
      alacritty # terminal
      blender # 3D modelling
      calibre # manage ebooks
      chromium # used for vhs
      discord # chat app
      firefox # alternative browser if qutebrowser doesn't work
      flameshot # screenshots
      gimp # image editing
      imagemagick # convert between image data type
      inkscape # drawing tool
      libresprite # pixel art tool
      musescore # musescore
      peek # gif capturing tool
      #qutebrowser # broswer with vim controls
      qutebrowser-qt6 # broswer with vim controls
      rustdesk # remote connection to other computers
      spotify # music
      tdesktop # telegram desktop app
      teamspeak_client # voice chat
      thunderbird # email client
      zulip # zulip client
      # unstable
      #godot_4 # game engine
      zathura # pdf reader

      # cli utils
      # gitoxide  # rusty git
      bat # better cat
      binutils
      blueberry # bluetooth config
      btop # better top
      butler # itch.io deploy
      cocogitto # git tooling for conventional commits and other stuff
      colorpicker # colorpicker
      delta # diffs
      difftastic
      du-dust # better du
      duf # shows free space on drives
      dunst # notifications
      exa # better ls
      exercism # exercism cli tool for downloading/submitting
      fd # better find
      fzf # fuzzy finder
      gh # github cli tool
      git # git
      git-cliff
      git-lfs # git large file storage
      glab # gitlab cli tool
      gum # cli scripting glue
      hoard # cli command saver
      hurl # test http requests
      jq # json cli processing
      just # make alternative
      license-generator # generate standard licenses
      lsof
      mdbook # pdf books from markdown
      hyperfine # benchmarking in terminal
      mpv # cli media player
      nix-index
      openssl # ssh
      pciutils
      ranger # cli file manager
      restream # stream remarkable to pc screen
      ripgrep # better grep
      sd # better sed
      taskwarrior # todo app
      tealdeer # shorter man with examples
      tokei # better loc
      tree # file tree vis
      unzip # zip
      vhs # terminal camera
      xdotool # automatically type text
      zip # zip
      zola # website generation
      zoxide # faster jumping around dirs
      zsh # better bash

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
      clang
      llvmPackages_9.bintools
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
      unstable.cargo-shuttle
      diesel-cli

      # haskell
      cabal-install
      cabal2nix
      haskellPackages.implicit-hie
      # hoogle generate doesn't work (timeout)
      haskellPackages.hoogle
      haskellPackages.fast-tags
      haskellPackages.haskell-debug-adapter
      haskellPackages.ghci-dap
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
      # nodejs

      # docker
      docker-compose

      # for getting ADM GPU Name
      libdrm
    ];
}
