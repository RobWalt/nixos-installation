{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { };
  stable = import <nixos> { };
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

  environment.systemPackages = with pkgs;
    [
      # apps
      alacritty
      discord
      libresprite
      qutebrowser
      restream
      teamspeak_client
      zathura
      spotify
      element-desktop
      unstable.appflowy

      # cli utils
      bat
      btop
      loc
      lsof
      delta
      difftastic
      du-dust
      duf
      exa
      fd
      fzf
      gh
      git
      git-lfs
      git-cliff
      just
      pass
      pciutils
      ripgrep
      sd
      tldr
      tree
      zip
      unzip
      zoxide
      zsh
      helix

      # graphics 
      vulkan-headers
      vulkan-tools
      vulkan-loader
      vulkan-extension-layer

      # ui
      brightnessctl
      i3lock-fancy
      mypolybar
      polybar

      # stuff
      clang
      killall
      pkg-config
      wget
      wpa_supplicant
      graphviz

      # audio
      stable.pamixer

      # rust
      (fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly

      wasm-bindgen-cli

      cargo-audit
      cargo-bloat
      cargo-deny
      cargo-generate
      cargo-edit
      cargo-expand
      cargo-fuzz
      cargo-llvm-lines
      cargo-make
      unstable.cargo-nextest
      cargo-outdated
      cargo-udeps
      cargo-watch
      hyperfine
      # not available yet
      #cargo-hack

      nodejs
      docker-compose
    ];
}
