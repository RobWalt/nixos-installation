{ pkgs, config, lib, bat-catppuccin, btop-catppuccin, ... }:
let
  names = import ../names.nix { };
  bat-catppuccin-program = import ./bat { inherit pkgs bat-catppuccin; };
  btop-catppuccin-program = import ./btop { inherit pkgs lib btop-catppuccin; };
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.users.${names.userName} = { ... }:
    {
      programs.home-manager.enable = true;

      home.stateVersion = config.system.stateVersion;
      home.username = "${names.userName}";
      home.homeDirectory = "/home/${names.userName}";

      imports = [
        ./alacritty
        ./dunst
        bat-catppuccin-program
        btop-catppuccin-program
        ./rofi
        ./tmux
        ./file-placement
        ./zsh
        ./git
      ];

      home.sessionPath = [
        "$HOME/.cargo/bin"
        "$HOME/.local/bin"
      ];

      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        defaultCacheTtl = 1800;
        enableSshSupport = true;
      };
    };
}
