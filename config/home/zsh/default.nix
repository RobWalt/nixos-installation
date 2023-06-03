{ pkgs, lib, ... }:
{

  imports = [
    # shell prompt
    ./starship
  ];

  programs.zsh = {
    # docs
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enable
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableVteIntegration = true;
    autocd = true;
    defaultKeymap = "viins";

    shellAliases = {

      # TODO Clean this up
      glab-info = "sh ~/.mygumscripts/glab-info.sh";
      glab-status = "sh ~/.mygumscripts/glab-status.sh";
      glab-mr = "sh ~/.mygumscripts/glab-mr.sh";
      glab-checklist = "sh ~/.mygumscripts/glab-checklist.sh";
      git-commit = "sh ~/.mygumscripts/git-commit.sh";
      git-recent-branches = "git branch --sort=-committerdate | head";
      glab-new-issue = "glab issue create";

      ccc = "cog commit chore";
      ccfe = "cog commit feat";
      ccfi = "cog commit fix";
      ccr = "cog commit refactor";
      ga = "git add";
      gaa = "git add -A";
      gc = "git checkout";
      gcb = "git checkout -b";
      gp = "git push";
      gpp = "git pull -p";
      grc = "git checkout -- .";
      grh = "git reset HEAD~";

      tmuxa = "sh ~/.tmux/init-tmux-all.sh";
      tmuxf = "sh ~/.tmux/init-tmux-freetime.sh";
      tmuxs = "sh ~/.tmux/init-tmux-system.sh";
      tmuxw = "sh ~/.tmux/init-tmux-work.sh";

      loc = "tokei";
      l = "exa -l";
      ll = "exa -alh";
      ls = "exa";
      cat = "bat";
      df = "duf";
      du = "dust";
      diff = "difft";
      find = "fd";

      init-bevy = "cp /home/robw/nix-shells/bevy.nix .";
      init-ns = "cp /home/robw/nix-shells/dev.nix .";
      init-wasm = "cp /home/robw/nix-shells/wasm.nix .";
      init-phone = "cp /home/robw/nix-shells/phone.nix .";

      remarkable = "restream -s reMarkable -p";
    };

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      save = 100000;
      size = 100000;
      path = "/home/robw/.zhistory";
    };

    historySubstringSearch = {
      enable = true;
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "nix-community/nix-zsh-completions"; }
        { name = "chisui/zsh-nix-shell"; }
      ];
    };

    initExtra = ''
      eval "$(zoxide init zsh)"
      eval $(ssh-agent) > /home/robw/.sshstartup.log && ssh-add /home/robw/.ssh/keys/* 2>> /home/robw/.sshstartup.log

      export NIX_BUILD_SHELL="zsh"

      source ~/.config/hoard/hoard.zsh

      fpath+=(~/.zfunc)
    '';
  };
}
