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
      spotify
      teamspeak_client
      zathura
      #unstable.appflowy

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
      sd
      tldr
      tree
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
      lldb
      killall
      pkg-config
      wget
      wpa_supplicant
      usbutils
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
      (fenix.rust-analyzer)

      # haskell
      stack
      ghc

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
