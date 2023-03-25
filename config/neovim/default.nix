{ pkgs, config, lib, ... }:
{
  nixpkgs.overlays =
    [
      (self: super: {
        neovim = super.neovim.override {
          configure = {
            packages.main = { start = (pkgs.callPackage ../vimplugins.nix { }).myvimplugins; };
            customRC = (pkgs.callPackage ../vimplugins.nix { }).myvimextraconfig;
          };
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
      marksman # markdown lsp
      #rust-analyzer
    ];
}
