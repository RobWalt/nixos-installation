{ lib, pkgs, ... }:
{
  environment.variables = {
    EDITOR = "nvim";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}


