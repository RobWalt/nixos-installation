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
      imagemagick
      inkscape
      libresprite
      blender
      mdbook
      qutebrowser
      restream
      spotify
      teamspeak_client
      zathura
      blueberry

      # ui
      eww

      # cli utils
      unstable.gum
      license-generator
      bat
      binutils
      btop
      delta
      difftastic
      du-dust
      jq
      dunst
      duf
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
      just
      tokei
      lsof
      pass
      pciutils
      ripgrep
      ranger
      sd
      tealdeer
      tree
      unzip
      xsel
      zip
      zola
      zoxide
      zsh

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
      cargo-generate
      cargo-edit
      cargo-expand
      cargo-fuzz
      cargo-llvm-lines
      unstable.cargo-make # latest version needed
      cargo-nextest
      cargo-outdated
      cargo-udeps
      cargo-watch
      hyperfine
      feroxbuster
      # not available yet
      #cargo-hack

      # haskell
      stack
      ghc
      haskell-language-server
      haskellPackages.implicit-hie

      # tidal cycles
      haskellPackages.tidal
      supercollider

      # lua
      luajit
      sumneko-lua-language-server

      # wasm
      wasm-bindgen-cli
      wasm-pack

      # javascript 
      nodejs

      # docker
      docker-compose
    ];
}
