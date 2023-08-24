{ pkgs, config, lib, inputs, ... }:
let
  inherit (inputs) adminName;
  importing = x: import x { inherit pkgs lib inputs; };
  bat-catppuccin-program = importing ./bat;
  btop-catppuccin-program = importing ./btop;
  file-placement = importing ./file-placement;
  git = importing ./git;
  zsh = importing ./zsh;
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.users.${adminName} = { ... }:
    {
      programs.home-manager.enable = true;

      home.stateVersion = config.system.stateVersion;
      home.username = "${adminName}";
      home.homeDirectory = "/home/${adminName}";

      imports = [
        ./alacritty
        ./dunst
        ./rofi
        ./tmux
        bat-catppuccin-program
        btop-catppuccin-program
        file-placement
        git
        zsh
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
