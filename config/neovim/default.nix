{ pkgs, config, lib, hlargs-src, yanky-src, ... }:
let
  vimplugins = pkgs.callPackage ./vimplugins.nix { inherit hlargs-src yanky-src; };
in
{
  nixpkgs.overlays =
    [
      (self: super: {
        aviac-neovim = super.neovim.override {
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
      gcc# needed for treesitter compilation
      git# needed for treesitter download
      manix# nix docs searcher
      rnix-lsp# nix lsp
      marksman# markdown lsp
      ;
  };

}
