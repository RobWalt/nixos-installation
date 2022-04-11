{ pkgs, config, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.users.robw = { ... }:
    {
      imports = [
        ./polybar.nix
        ./zsh.nix
        ./alacritty.nix
        ./rofi.nix
      ];

      programs.home-manager.enable = true;

      programs.git = {
        enable = true;
        userName = "RobWalt";
        userEmail = "robwalter96@gmail.com";
        extraConfig = {
          pull.rebase = false;
          merge.tool = "nvimdiff";
        };
      };

      services.picom = {
        enable = true;
      };

    };
}
