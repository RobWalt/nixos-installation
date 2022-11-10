{ pkgs, config, lib, ... }:
let
  stable = import <nixos> { };
  unstable = import <nixos-unstable> { };
in
{
  nixpkgs.overlays =
    [
      (self: super: {
        neovim = super.neovim.override {
          # unstable until 0.8 hits stable
          # configure = {
          #   packages.main = { start = (pkgs.callPackage ../vimplugins.nix { }).myvimplugins; };
          #   customRC = (pkgs.callPackage ../vimplugins.nix { }).myvimextraconfig;
          # };
        };
      })
    ];

  environment.systemPackages = with pkgs;
    [
      neovim
      clang # needed for rust-tools
      gcc # needed for treesitter compilation
      git # needed for treesitter download
      rnix-lsp # nix lsp
      #rust-analyzer
    ];
}
