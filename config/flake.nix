{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    yanky-src = {
      url = "github:gbprod/yanky.nvim";
      flake = false;
    };
    hlargs-src = {
      url = "github:m-demare/hlargs.nvim";
      flake = false;
    };
  };
  outputs = { nixpkgs, unstable, home-manager, ... }@inputs: {
    nixosConfigurations =
      let
        defaults = { pkgs, ... }: {
          _module.args =
            let
              make-available-in-args = p: import p { inherit (pkgs.stdenv.targetPlatform) system; };
            in
            {
              unstable = make-available-in-args inputs.unstable;
              inputs = inputs;
            };
        };
      in
      {
        robw = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              home-manager.nixosModules.home-manager
              defaults
              ./my_uwu_system.nix
            ];
        };
      };
  };
}
