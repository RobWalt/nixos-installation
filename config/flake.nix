{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/f1490b8caf2ef6f59205c78cf1a8b68e776214a3";
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
              defaults
              home-manager.nixosModules.home-manager
              ./my_uwu_system.nix
            ];
        };
      };
  };
}
