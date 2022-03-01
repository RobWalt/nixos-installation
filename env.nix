{ lib, ... }:
{
  environment.variables = {
    EDITOR = "nvim";
    TERM = "alacritty";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
