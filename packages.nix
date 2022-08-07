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
      firefox
      flameshot
      gimp
      helix
      imagemagick
      inkscape
      eww
      libresprite
      mdbook
      qutebrowser
      restream
      spotify
      supercollider
      teamspeak_client
      zathura

      # cli utils
      unstable.gum
      bat
      binutils
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
      git-cliff
      git-lfs
      gitoxide
      glab
      just
      loc
      lsof
      pass
      pciutils
      ripgrep
      sd
      tealdeer
      tmux
      tree
      unzip
      xsel
      zip
      zola
      zoxide
      zsh

      # graphics 
      vulkan-headers
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
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
      rustup
      rust-analyzer

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
      haskellPackages.tidal
      haskellPackages.implicit-hie

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
