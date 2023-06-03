{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    clock24 = true;
    aggressiveResize = false;
    sensibleOnTop = false;
    terminal = "alacritty";
    keyMode = "vi";
    shell = "${pkgs.zsh}/bin/zsh";

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.tmux-fzf;
        extraConfig = ''
          bind-key "l" run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/window.sh switch"
        '';
      }
      {
        plugin = tmuxPlugins.battery;
        extraConfig = '' 
          set -g status-right 'Batt: #{battery_percentage} | %a %h-%d %H:%M '
        '';
      }
    ];

    extraConfig = ''
      set-option -g status-style bg=black
      set-option -g status-style fg=yellow

      set-option -ga terminal-overrides ",alacritty:Tc"
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

      set-option -g exit-empty off
      set-option -g exit-unattached off

      set -g mouse on
    '';
  };
}

