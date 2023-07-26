{ pkgs, lib, btop-catppuccin, ... }:
{
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "catppuccin-mocha";
    };
  };

  # btop themes
  home.file.".config/btop/themes/catppuccin-latte.theme".text = builtins.readFile "${btop-catppuccin}/themes/catppuccin_latte.theme";
  home.file.".config/btop/themes/catppuccin-frappe.theme".text = builtins.readFile "${btop-catppuccin}/themes/catppuccin_frappe.theme";
  home.file.".config/btop/themes/catppuccin-macchiato.theme".text = builtins.readFile "${btop-catppuccin}/themes/catppuccin_macchiato.theme";
  home.file.".config/btop/themes/catppuccin-mocha.theme".text = builtins.readFile "${btop-catppuccin}/themes/catppuccin_mocha.theme";
}
