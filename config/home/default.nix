{ pkgs, config, lib, bat-catppuccin, ... }:
let
  names = import ../names.nix { };
  bat-catppuccin-program = import ./bat { inherit pkgs bat-catppuccin; };
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
        ./rofi
        ./tmux
        ./zsh
        ./file-placement
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
    } // bat-catppuccin-program;
}
