{ pkgs, config, lib, ... }:
{
  # install custom neovim system wide to also have it when doing stuff with root
  nixpkgs.overlays =
    [
      (self: super: {
        neovim = super.neovim.override {
          configure = {
            packages.main = {
              start = (pkgs.callPackage ./vimplugins.nix { }).myvimplugins;
            };
            # kind of sucks that the configurations all have to start/end with
            # the lua code block symbols in here but ok
            customRC = (pkgs.callPackage ./vimplugins.nix { }).myvimextraconfig;
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
      rnix-lsp # nix lsp
      marksman # markdown lsp
    ];
}
