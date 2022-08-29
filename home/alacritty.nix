{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      # Define
      window = {
        opacity = 0.9;
      };
      colors = {
        primary = {
          background = "#2b3339";
          foreground = "#d3c6aa";
        };
        normal = {
          black = "#4b565c";
          red = "#e67e80";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
        };
        bright = {
          black = "#4b565c";
          red = "#e67e80";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
        };
      };
      font = {
        normal = {
          family = "Iosevka Nerd Font Mono";
          style = "Regular";
        };
      };
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        #args = [
        #  "-l"
        #  "-c"
        #  "tmux attach || tmux"
        #];
      };
    };
  };
}
