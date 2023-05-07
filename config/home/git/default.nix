{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "RobWalt";
    userEmail = "robwalter96@gmail.com";
    hooks = {
      pre-commit = hooks/pre-commit.sh;
    };
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

}
