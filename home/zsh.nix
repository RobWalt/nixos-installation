{ pkgs, lib, ... }:
{
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

  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;

    shellAliases = {
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
      glab-get = "glab issue list --assignee=@me && glab mr list --assignee=@me";
      glab-new-issue = "glab issue create";
      glab-todo = "f() { glab issue update $1 -u \"Doing\" -u \"Review-Ready\" -l \"To-Do\" };f";
      glab-doing = "f() { glab issue update $1 -u \"To-Do\" -u \"Review-Ready\" -l \"Doing\" };f";
      glab-review = "f() { glab issue update $1 -u \"To-Do\" -u \"Doing\" -l \"Review-Ready\" };f";
      glab-mr-create = "f() { glab mr create --target-branch $1 };f";
      glab-mr-target = "f() { glab mr update --target-branch $1 };f";
      glab-mr-reviewer = "f() { glab mr update --reviewer $1 };f";
      gh-get = "gh issue list --assignee=@me && gh pr list --assignee=@me";
      init-ns = "cp /home/robw/nix-shells/dev.nix .";
      init-wasm = "cp /home/robw/nix-shells/wasm.nix .";
      run-ns = "nix-shell dev.nix || nix-shell shell.rob.nix || nix-shell";
      wasm-ns = "nix-shell wasm.nix";
      wasm-start = "/home/robw/.cargo/bin/wasm-server-runner";
      remarkable = "restream -s 192.168.0.143 -p";
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
}
