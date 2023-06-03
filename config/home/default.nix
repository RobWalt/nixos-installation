{ pkgs, config, lib, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.users.robw = { ... }:
    {
      home.stateVersion = config.system.stateVersion;

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

      programs.home-manager.enable = true;
      programs.gpg.enable = true;

    };
}
