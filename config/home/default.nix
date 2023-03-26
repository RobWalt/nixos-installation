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
      ];

      home.sessionPath = [
        "$HOME/.cargo/bin"
        "$HOME/.local/bin"
      ];

      programs.home-manager.enable = true;

      programs.git = {
        enable = true;
        userName = "RobWalt";
        userEmail = "robwalter96@gmail.com";
        extraConfig = {
          pull.rebase = false;
          merge.tool = "nvimdiff";
          core.pager = "delta";
          interactive.diffFilter = "delta --color-only";
          delta.navigate = true;
          merge.conflictstyle = "diff3";
          diff.colorMoved = "default";
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
        };
      };

      programs.gpg = {
        enable = true;
      };

    };
}
