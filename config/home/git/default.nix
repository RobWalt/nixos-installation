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
      commit.gpgsign = true;
      core.pager = "delta";
      delta.navigate = true;
      diff.colorMoved = "default";
      init.defaultBranch = "main";
      interactive.diffFilter = "delta --color-only";
      merge.conflictstyle = "diff3";
      merge.tool = "nvimdiff";
      pull.rebase = true;
      push.autoSetupRemote = true;
      user.signingKey = "31D5FB29";
    };
  };

}
