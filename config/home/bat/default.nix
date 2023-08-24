{ pkgs, inputs, ... }:
let inherit (inputs) bat-catppuccin; in
{
  programs.bat = {
    enable = true;
    themes = {
      catppuccin = builtins.readFile "${bat-catppuccin}/Catppuccin-mocha.tmTheme";
    };
  };
}
