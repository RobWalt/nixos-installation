{ lib, ... }:
let
  # fg = "#323d43";
  # c0 = "#d699b6";
  # c1 = "#dd9ab0";
  # c2 = "#e39ba9";
  # c3 = "#e89da2";
  # c4 = "#eba09b";
  # c5 = "#eca394";
  # c6 = "#eca78e";
  # c7 = "#eaac88";
  # c8 = "#e6b184";
  # c9 = "#e1b681";
  # c10 = "#dbbc7f";
  # cnix = "#9BC8D1";
  fg = "#000000";
  cnix = "#94E2D5";
  c10 = "#8FDFE0";
  c9 = "#89DCEB";
  c8 = "#7FD2EC";
  c7 = "#74C7EC";
  c6 = "#7FBEF3";
  c5 = "#89B4FA";
  c4 = "#9FB9FC";
  c3 = "#b4befe";
  c2 = "#B4BEFE";
  c1 = "#C1CAF9";
  c0 = "#CDD6F4";
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [
        "[ ](bg:${c0})"
        "$username"
        "[](fg:${c0} bg:${c1})"
        "[](fg:${c1} bg:${c2})"
        "$directory"
        "[](fg:${c2} bg:${c3})"
        "[](fg:${c3} bg:${c4})"
        "$git_branch"
        "$git_status"
        "[](fg:${c4} bg:${c5})"
        "[](fg:${c5} bg:${c6})"
        "$rust"
        "[](fg:${c6} bg:${c7})"
        "[](fg:${c7} bg:${c8})"
        "$time"
        "[](fg:${c8} bg:${c9})"
        "[](fg:${c9} bg:${c10})"
        "[ 󱗆 ](bg:${c10} fg:${fg})"
        "[ ](fg:${c10})"
        "$nix_shell"
      ];
      add_newline = false;
      nix_shell = {
        format = lib.concatStrings [
          "[](fg:${cnix})"
          "[ $symbol]($style)"
          "[ ](fg:${cnix})"
        ];
        style = "bg:${cnix} fg:${fg}";
      };
      username = {
        show_always = true;
        style_user = "bg:${c0} fg:${fg}";
        style_root = " bg:${c0} fg:${fg}";
        format = "[ $user ]($style)";
      };
      directory = {
        style = "bg:${c2} fg:${fg}";
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
        style = "bg:${c4} fg:${fg}";
        format = "[[ $symbol $branch ](bg:${c4} fg:${fg})]($style)";
      };
      git_status = {
        style = "bg:${c4} fg:${fg}";
        format = "[[($all_status$ahead_behind )](bg:${c4} fg:${fg})]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:${c6} fg:${fg}";
        format = "[[ $symbol ($version) ](bg:${c6} fg:${fg})]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:${c8} fg:${fg}";
        format = "[[  $time ](bg:${c8} fg:${fg})]($style)";
      };
    };
  };
}
