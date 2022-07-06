{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { };
in
{
  nixpkgs.overlays = with pkgs;
    [
      (self: super: {
        mypolybar = polybar.override {
          i3Support = true;
        };
      })
      (import "${fetchTarball "https://github.com/nix-community/fenix/archive/main.tar.gz"}/overlay.nix")
    ];

  programs.adb.enable = true;

  environment.systemPackages = with pkgs;
    [
      # apps
      alacritty
      discord
      element-desktop
      flameshot
      gimp
      helix
      imagemagick
      inkscape
      libresprite
      mdbook
      qutebrowser
      restream
      supercollider
      spotify
      teamspeak_client
      zathura

      # cli utils
      bat
      btop
      delta
      difftastic
      du-dust
      duf
      exa
      exercism
      fd
      fzf
      gh
      git
      gitoxide
      git-cliff
      git-lfs
      glab
      just
      loc
      lsof
      pass
      pciutils
      ripgrep
      xsel
      sd
      tldr
      tree
      tmux
      unzip
      zip
      zola
      zoxide
      zsh

      # graphics 
      vulkan-headers
      vulkan-tools
      vulkan-loader
      vulkan-extension-layer

      # ui
      brightnessctl
      i3lock-fancy
      mypolybar

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
      (fenix.stable.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
      ])
      (fenix.complete.withComponents [
        #  "cargo"
        #  "clippy"
        #  "rust-src"
        #  "rustc"
        "rustfmt"
      ])
      rust-analyzer

      # haskell
      stack
      ghc
      haskell-language-server
      haskellPackages.tidal
      haskellPackages.implicit-hie

      # lua
      luajit
      sumneko-lua-language-server

      # wasm
      wasm-bindgen-cli
      wasm-pack

      cargo-audit
      cargo-bloat
      cargo-deny
      cargo-generate
      cargo-edit
      cargo-expand
      cargo-fuzz
      cargo-llvm-lines
      #cargo-make
      cargo-nextest
      cargo-outdated
      cargo-udeps
      cargo-watch
      unstable.cargo-make
      hyperfine
      # not available yet
      #cargo-hack

      nodejs
      docker-compose
    ];
}
