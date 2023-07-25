{ pkgs, bat-catppuccin, ... }: {
  programs.bat = {
    enable = true;
    themes = {
      catppuccin = builtins.readFile "${bat-catppuccin}/Catppuccin-mocha.tmTheme";
    };
  };
}
