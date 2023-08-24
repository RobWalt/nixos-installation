{ pkgs, lib, inputs, ... }:
let inherit (inputs) adminName; in
{
  programs.git = {
    enable = true;
    userName = "RobWalt";
    userEmail = "robwalter96@gmail.com";
    aliases = {
      recent-branch = "branch --sort=-committerdate | head";
      aa = "add -A";
      st = "status";
      sw = "switch";
      co = "chechout";
      cob = "checkout -b";
      p = "push";
      pp = "pull -p";
      rh = "reset HEAD~";
      re = "restore";
      clean = "clean -d -f";
      s = "stash";
      sp = "stash pop";
      sb = "stash branch";
      px = "log -S";
      ll = "log -L";
      check-whitespace = "diff --ws-error-highlight=new";
    };
    hooks = {
      pre-commit = pkgs.writeTextFile {
        name = "pre-commit.sh";
        text = pkgs.callPackage hooks/pre-commit.nix { inherit adminName; };
        executable = true;
      };
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
