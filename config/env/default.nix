{ lib, pkgs, ... }:
{
  environment.variables = {
    EDITOR = "nvim";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    NIX_BUILD_SHELL = "zsh";
  };

  # needed to get completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];
}


