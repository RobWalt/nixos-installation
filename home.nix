{ pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.robw = {
    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName = "RobWalt";
      userEmail = "robwalter96@gmail.com";
      extraConfig = {
        pull.rebase = false;
      };
    };

    programs.alacritty = {
      enable = true;
    };

  };
}
