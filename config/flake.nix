{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    yanky-src = {
      url = "github:gbprod/yanky.nvim";
      flake = false;
    };
    hlargs-src = {
      url = "github:m-demare/hlargs.nvim";
      flake = false;
    };
    neorg-telescope-src = {
      url = "github:nvim-neorg/neorg-telescope";
      flake = false;
    };
  };
  outputs = { nixpkgs, unstable, home-manager, ... }@inputs: {
    nixosConfigurations = {
      robw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules =
          let
            defaults = { pkgs, ... }: {
              _module.args =
                let
                  make-available-in-args = p: import p { inherit (pkgs.stdenv.targetPlatform) system; };
                in
                {
                  unstable = make-available-in-args inputs.unstable;
                };
            };
          in
          [
            home-manager.nixosModules.home-manager
            defaults
            ./my_uwu_system.nix
          ];
      };
    };
  };
}
