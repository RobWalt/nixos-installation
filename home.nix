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

    # git
    programs.git = import ./git.nix {
      name = "RobWalt";
      email = "robwalter96@gmail.com";
    };

    programs.alacritty = {
      enable = true;
    };

  };
}
