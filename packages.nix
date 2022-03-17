{ pkgs, ... }:
{
  nixpkgs.overlays = with pkgs;
    [
      (self: super: {
        mypolybar = polybar.override {
          i3Support = true;
        };
      })
    ];

  environment.systemPackages = with pkgs;
    [
      alacritty
      rofi
      qutebrowser

      gh

      git
      wget
      killall

      ripgrep
      fd

      mypolybar
      polybar
      zsh

      rustup
      clang

      brightnessctl
      wpa_supplicant
      rmapi
      just
      tree

      pkg-config
      pamixer

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

      nodejs
      docker-compose

      # everything needed for neovim
      clang # needed for rust-tools
      gcc # needed for treesitter compilation
      git # needed for treesitter download
      rnix-lsp # nix lsp
      rust-analyzer # rust lsp
    ];
}
