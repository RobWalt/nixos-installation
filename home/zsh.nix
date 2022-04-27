{ pkgs, lib, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # format = lib.concatStrings [
      #   "[ ](bg:#d699b6)"
      #   "$username"
      #   "[](fg:#d699b6 bg:#e69ca6)"
      #   "[](fg:#e69ca6 bg:#eca394 )"
      #   "$directory"
      #   "[](fg:#eca394 bg:#e8ae86)"
      #   "[](fg:#e8ae86 bg:#dbbc7f)"
      #   "$git_branch"
      #   "$git_status"
      #   "[](fg:#dbbc7f bg:#bcc085)"
      #   "[](fg:#bcc085 bg:#9fc193)"
      #   "$rust"
      #   "[](fg:#9fc193 bg:#8abfa4)"
      #   "[](fg:#8abfa4 bg:#7fbbb3)"
      #   "$time"
      #   "[](fg:#7fbbb3 bg:#aac2a4)"
      #   "[](fg:#aac2a4 bg:#d3c6aa)"
      #   "[  ](bg:#d3c6aa fg:#323d43)"
      #   "[ ](fg:#d3c6aa)"
      # ];
      # add_newline = false;
      # username = {
      #   show_always = true;
      #   style_user = "bg:#d699b6 fg:#323d43";
      #   style_root = "bg:#d699b6 fg:#323d43";
      #   format = "[ $user ]($style)";
      # };
      # directory = {
      #   style = "bg:#eca394 fg:#323d43";
      #   format = "[  $path ]($style)";
      #   truncation_length = 3;
      #   truncation_symbol = "…/";
      #   substitutions = {
      #     "Documents" = "  ";
      #     "Downloads" = "  ";
      #     "Music" = "  ";
      #     "Pictures" = "  ";
      #     "Important  " = "  ";
      #   };
      # };
      # git_branch = {
      #   symbol = "";
      #   style = "bg:#dbbc7f fg:#323d43";
      #   format = "[[ $symbol $branch ](bg:#dbbc7f fg:#323d43)]($style)";
      # };
      # git_status = {
      #   style = "bg:#dbbc7f fg:#323d43";
      #   format = "[[($all_status$ahead_behind )](bg:#dbbc7f fg:#323d43)]($style)";
      # };
      # rust = {
      #   symbol = "";
      #   style = "bg:#9fc193 fg:#323d43";
      #   format = "[[ $symbol ($version) ](bg:#9fc193 fg:#323d43)]($style)";
      # };
      # time = {
      #   disabled = false;
      #   time_format = "%R";
      #   style = "bg:#7fbbb3 fg:#323d43";
      #   format = "[[  $time ](bg:#7fbbb3 fg:#323d43)]($style)";
      # };
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
      remarkable = "restream -s 192.168.0.143 -p";
    };

    history = {
      size = 100000;
      path = ".zhistory";
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
