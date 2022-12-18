{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { };
in
{

  environment.systemPackages = with pkgs;
    [
      # apps
      alacritty
      discord
      flameshot
      gimp
      firefox
      helix
      tdesktop
      imagemagick
      inkscape
      libresprite
      blender
      mdbook
      rustdesk
      qutebrowser
      peek
      restream
      spotify
      teamspeak_client
      zathura
      blueberry

      # ui
      eww

      # cli utils
      bat
      binutils
      btop
      delta
      difftastic
      du-dust
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
      hurl
      jq
      just
      license-generator
      lsof
      pass
      pciutils
      ranger
      ripgrep
      sd
      tealdeer
      tokei
      tree
      unstable.gum
      unzip
      xclip
      zip
      zola
      zoxide
      zsh

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
      graphviz

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
      unstable.cargo-make # latest version needed
      hyperfine
      feroxbuster
      # not available yet
      #cargo-hack

      #kind
      unstable.kind2

      # haskell
      cabal-install
      cabal2nix
      haskellPackages.implicit-hie
      ghc
      haskell-language-server
      ormolu

      # tidal cycles
      haskellPackages.tidal
      supercollider

      # local markdown slides
      jekyll

      # lua
      luajit
      sumneko-lua-language-server

      # wasm
      # wasm-bindgen-cli # not always up to date
      wasm-pack

      # javascript 
      nodejs

      # docker
      docker-compose
    ];
}
