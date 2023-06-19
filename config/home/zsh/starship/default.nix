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
  cnix = "#74C7EC";
  c10 = "#7FBEF3";
  c9 = "#89B4FA";
  c8 = "#90B6FA";
  c7 = "#99B8FB";
  c6 = "#A2BAFC";
  c5 = "#ABBCFD";
  c4 = "#B4BEFE";
  c3 = "#BBC4FD";
  c2 = "#C1CAFA";
  c1 = "#C7D0F7";
  c0 = "#CDD6F4";
  # rosewater = "#f5e0dc"
  # flamingo = "#f2cdcd"
  # pink = "#f5c2e7"
  # mauve = "#cba6f7"
  # red = "#f38ba8"
  # maroon = "#eba0ac"
  # peach = "#fab387"
  # yellow = "#f9e2af"
  # green = "#a6e3a1"
  # teal = "#94e2d5"
  # sky = "#89dceb"
  # sapphire = "#9CAFD8"
  # blue = "#89b4fa"
  # lavender = "#b4befe"
  # text = "#cdd6f4"
  # subtext1 = "#bac2de"
  # subtext0 = "#a6adc8"
  # overlay2 = "#9399b2"
  # overlay1 = "#7f849c"
  # overlay0 = "#6c7086"
  # surface2 = "#585b70"
  # surface1 = "#45475a"
  # surface0 = "#313244"
  # base = "#1e1e2e"
  # mantle = "#181825"
  # crust = "#11111b"
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
          "Documents" = " 󰧮 ";
          "Downloads" = "  ";
          "Music" = "  ";
          "Pictures" = "  ";
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
