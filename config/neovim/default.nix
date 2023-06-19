{ pkgs, config, lib, inputs, ... }:
{
  # install custom neovim system wide to also have it when doing stuff with root
  nixpkgs.overlays =
    [
      (self: super: {
        neovim = super.neovim.override {
          configure = {
            packages.main = {
              start = (pkgs.callPackage ./vimplugins.nix { inherit inputs; }).myvimplugins;
            };
            # kind of sucks that the configurations all have to start/end with
            # the lua code block symbols in here but ok
            customRC = (pkgs.callPackage ./vimplugins.nix { inherit inputs; }).myvimextraconfig;
          };
        };
      })
    ];

  # make sure everything needed is always available with neovim
  environment.systemPackages = with pkgs;
    [
      neovim
      clang # needed for rust-tools
      gcc # needed for treesitter compilation
      git # needed for treesitter download
      manix # nix docs searcher
      rnix-lsp # nix lsp
      marksman # markdown lsp
    ];
}
