{ pkgs, ... }:
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
      qutebrowser
      rmapi
      restream
      teamspeak_client
      zathura

      # cli utils
      btop
      zsh
      du-dust
      gh
      git
      git-lfs
      ripgrep
      fd
      just
      tree
      zk

      # ui
      mypolybar
      polybar
      brightnessctl

      # stuff
      wget
      killall
      clang
      wpa_supplicant
      pkg-config

      # audio
      pulseaudio
      pamixer
      pavucontrol

      # rust
      (fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly

      hyperfine
      cargo-edit
      cargo-make
      cargo-deny
      cargo-audit
      cargo-fuzz
      cargo-expand
      cargo-llvm-lines
      cargo-watch
      cargo-udeps
      cargo-outdated
      cargo-bloat
      # not available yet
      #cargo-hack
      #cargo-nextest

      pass

      nodejs
      docker-compose
    ];
}
