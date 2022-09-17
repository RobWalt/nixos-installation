{ pkgs, lib, ... }:
{

  # Utility functions for other scripts
  home.file.".mygumscripts/utils.sh".source = ./scripts/utils.sh;

  # user friendly cli scripts
  home.file.".mygumscripts/glab-info.sh".source = ./scripts/glab-info.sh;
  home.file.".mygumscripts/glab-status.sh".source = ./scripts/glab-status.sh;
  home.file.".mygumscripts/glab-mr.sh".source = ./scripts/glab-mr.sh;
  home.file.".mygumscripts/glab-checklist.sh".source = ./scripts/glab-checklist.sh;
  home.file.".mygumscripts/git-commit.sh".source = ./scripts/git-commit.sh;

  home.file.".tmux/init-tmux-work.sh".source = ./scripts/init-tmux-work.sh;
  home.file.".tmux/init-tmux-system.sh".source = ./scripts/init-tmux-system.sh;
  home.file.".tmux/init-tmux-all.sh".source = ./scripts/init-tmux-all.sh;
  home.file.".tmux/init-tmux-freetime.sh".source = ./scripts/init-tmux-freetime.sh;

  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;

    shellAliases = {
      glab-info = "sh ~/.mygumscripts/glab-info.sh";
      glab-status = "sh ~/.mygumscripts/glab-status.sh";
      glab-mr = "sh ~/.mygumscripts/glab-mr.sh";
      glab-checklist = "sh ~/.mygumscripts/glab-checklist.sh";
      git-commit = "sh ~/.mygumscripts/git-commit.sh";
      git-initpush = "git push --set-upstream origin $(git branch --show-current)";
      glab-new-issue = "glab issue create";
      tmuxw = "sh ~/.tmux/init-tmux-work.sh";
      tmuxa = "sh ~/.tmux/init-tmux-all.sh";
      tmuxf = "sh ~/.tmux/init-tmux-freetime.sh";
      tmuxs = "sh ~/.tmux/init-tmux-system.sh";
      loc = "tokei";
      l = "exa -l";
      ll = "exa -alh";
      ls = "exa";
      cat = "bat";
      df = "duf";
      du = "dust";
      sed = "sd";
      diff = "difft";
      grep = "rg";
      find = "fd";
      gh-get = "gh issue list --assignee=@me && gh pr list --assignee=@me";
      init-bevy = "cp /home/robw/nix-shells/bevy.nix .";
      init-ns = "cp /home/robw/nix-shells/dev.nix .";
      init-wasm = "cp /home/robw/nix-shells/wasm.nix .";
      run-ns = "nix-shell dev.nix || nix-shell shell.rob.nix || nix-shell";
      wasm-ns = "nix-shell wasm.nix";
      wasm-start = "/home/robw/.cargo/bin/wasm-server-runner";
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
      ];
    };

    initExtra = ''
      eval "$(zoxide init zsh)"
      eval $(ssh-agent) > /home/robw/.sshstartup.log && ssh-add /home/robw/.ssh/keys/* 2>> /home/robw/.sshstartup.log
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[ ](bg:#d699b6)"
        "$username"
        "[](fg:#d699b6 bg:#dd9ab0)"
        "[](fg:#dd9ab0 bg:#e39ba9)"
        "$directory"
        "[](fg:#e39ba9 bg:#e89da2)"
        "[](fg:#e89da2 bg:#eba09b)"
        "$git_branch"
        "$git_status"
        "[](fg:#eba09b bg:#eca394)"
        "[](fg:#eca394 bg:#eca78e)"
        "$rust"
        "[](fg:#eca78e bg:#eaac88)"
        "[](fg:#eaac88 bg:#e6b184)"
        "$time"
        "[](fg:#e6b184 bg:#e1b681)"
        "[](fg:#e1b681 bg:#dbbc7f)"
        "[  ](bg:#dbbc7f fg:#323d43)"
        "[ ](fg:#dbbc7f)"
      ];
      add_newline = false;
      username = {
        show_always = true;
        style_user = "bg:#d699b6 fg:#323d43";
        style_root = "bg:#d699b6 fg:#323d43";
        format = "[ $user ]($style)";
      };
      directory = {
        style = "bg:#e39ba9 fg:#323d43";
        format = "[  $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "  ";
          "Downloads" = "  ";
          "Music" = "  ";
          "Pictures" = "  ";
          "Important  " = "  ";
        };
      };
      git_branch = {
        symbol = "";
        style = "bg:#eba09b fg:#323d43";
        format = "[[ $symbol $branch ](bg:#eba09b fg:#323d43)]($style)";
      };
      git_status = {
        style = "bg:#eba09b fg:#323d43";
        format = "[[($all_status$ahead_behind )](bg:#eba09b fg:#323d43)]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:#eca78e fg:#323d43";
        format = "[[ $symbol ($version) ](bg:#eca78e fg:#323d43)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#e6b184 fg:#323d43";
        format = "[[  $time ](bg:#e6b184 fg:#323d43)]($style)";
      };
    };
  };
}
