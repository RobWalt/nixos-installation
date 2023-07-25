{ pkgs, lib, ... }:
let
  names = import ../../names.nix { };
in
{

  imports = [
    ./starship # shell prompt
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
      gst = "git status";
      gc = "git checkout";
      gcb = "git checkout -b";
      gp = "git push";
      gpp = "git pull -p";
      grh = "git reset HEAD~";

      tmuxa = "sh ~/.tmux/init-tmux-all.sh";
      tmuxf = "sh ~/.tmux/init-tmux-freetime.sh";
      tmuxs = "sh ~/.tmux/init-tmux-system.sh";
      tmuxw = "sh ~/.tmux/init-tmux-work.sh";

      loc = "tokei";

      ls = "exa";
      l = "exa -l";
      ll = "exa -alh";
      lt = "exa --tree --header --icons --git";
      tree1 = "lt --level=1";
      tree2 = "lt --level=2";
      tree3 = "lt --level=3";

      cat = "bat --theme=catppuccin";

      df = "duf";
      du = "dust";
      diff = "difft";
      find = "fd";

      init-bevy = "cp /home/${names.userName}/nix-shells/bevy.nix .";
      init-ns = "cp /home/${names.userName}/nix-shells/dev.nix .";
      init-wasm = "cp /home/${names.userName}/nix-shells/wasm.nix .";
      init-phone = "cp /home/${names.userName}/nix-shells/phone.nix .";

      remarkable = "restream -s reMarkable -p";
    };

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      save = 100000;
      size = 100000;
      path = "/home/${names.userName}/.zhistory";
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
      eval $(ssh-agent) > /home/${names.userName}/.sshstartup.log && ssh-add /home/${names.userName}/.ssh/keys/* 2>> /home/${names.userName}/.sshstartup.log

      export NIX_BUILD_SHELL="zsh"

      source ~/.config/hoard/hoard.zsh

      fpath+=(~/.zfunc)
    '';
  };
}
