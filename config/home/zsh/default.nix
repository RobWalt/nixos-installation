{ pkgs, lib, ... }:
{

  imports = [
    # shell prompt
    ./starship
  ];

  programs.zsh = {

    enable = true;

    enableAutosuggestions = true;

    shellAliases = {

      # TODO Clean this up
      glab-info = "sh ~/.mygumscripts/glab-info.sh";
      glab-status = "sh ~/.mygumscripts/glab-status.sh";
      glab-mr = "sh ~/.mygumscripts/glab-mr.sh";
      glab-checklist = "sh ~/.mygumscripts/glab-checklist.sh";
      git-commit = "sh ~/.mygumscripts/git-commit.sh";
      git-recent-branches = "git branch --sort=-committerdate | head";
      glab-new-issue = "glab issue create";

      tmuxa = "sh ~/.tmux/init-tmux-all.sh";
      tmuxf = "sh ~/.tmux/init-tmux-freetime.sh";
      tmuxn = "sh ~/.tmux/init-tmux-neorg.sh";
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
      size = 100000;
      path = "/home/robw/.zhistory";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-history-substring-search"; }
      ];
    };

    initExtra = ''
      eval "$(zoxide init zsh)"
      eval $(ssh-agent) > /home/robw/.sshstartup.log && ssh-add /home/robw/.ssh/keys/* 2>> /home/robw/.sshstartup.log

      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      source ~/.config/hoard/hoard.zsh

      fpath+=(~/.zfunc)
    '';
  };
}
