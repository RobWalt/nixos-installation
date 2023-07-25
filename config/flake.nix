{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    old-nixpkgs.url = "github:NixOS/nixpkgs/23.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";

    # 23.05 release commit tagged
    home-manager.url = "github:nix-community/home-manager/f1490b8caf2ef6f59205c78cf1a8b68e776214a3";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # extra stuff not available in nixpkgs yet
    yanky-src = {
      url = "github:gbprod/yanky.nvim";
      flake = false;
    };
    hlargs-src = {
      url = "github:m-demare/hlargs.nvim";
      flake = false;
    };
    bat-catppuccin = {
      url = "github:catppuccin/bat";
      flake = false;
    };
  };
  outputs =
    { nixpkgs
    , old-nixpkgs
    , unstable
    , home-manager
    , flake-utils
    , yanky-src
    , hlargs-src
    , bat-catppuccin
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (system:
    {
      packages.nixosConfigurations =
        let
          names = import ./names.nix { };
          specialArgs = {
            unstable = import unstable { inherit system; };
            oldpkgs = import old-nixpkgs { inherit system; };
            inherit hlargs-src yanky-src bat-catppuccin;
          };
        in
        {
          ${names.hostName} = nixpkgs.lib.nixosSystem {
            inherit
              system# inherit system
              specialArgs# make other args available
              ;

            # load modules
            modules =
              [
                home-manager.nixosModules.home-manager
                ./configuration.nix
              ];
          };
        };
    });
}
