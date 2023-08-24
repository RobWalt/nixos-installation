{ pkgs, config, lib, unstable, inputs, ... }:
let
  vimplugins = pkgs.callPackage ./vimplugins.nix { inherit unstable inputs; };
in
{
  nixpkgs.overlays =
    [
      (self: super: {
        aviac-neovim = unstable.neovim.override {
          configure = {
            packages.main = {
              start = vimplugins.pluginList;
            };
            customRC = vimplugins.extraConfig;
          };
        };
      })
    ];

  # make sure everything needed is always available with neovim
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      aviac-neovim
      ;
    inherit (pkgs.nodePackages)
      cspell# spelling checker code actions
      ;
    inherit (unstable)
      # using unstable version see system packages
      typst-lsp# typst lsp
      statix# another nix lsp for lints and suggestions
      rnix-lsp# nix lsp for formatting mainly
      manix# nix docs searcher
      marksman# markdown lsp
      ;
  };

}
