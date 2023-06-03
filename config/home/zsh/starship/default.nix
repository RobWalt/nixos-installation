{ lib, ... }: {
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
        "[ 󱗆 ](bg:#dbbc7f fg:#323d43)"
        "[ ](fg:#dbbc7f)"
        "$nix_shell"
      ];
      add_newline = false;
      nix_shell = {
        format = lib.concatStrings [
          "[](fg:#9BC8D1)"
          "[ $symbol]($style)"
          "[ ](fg:#9BC8D1)"
        ];
        style = "bg:#9BC8D1 fg:#323d43";
      };
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
