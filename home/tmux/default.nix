{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    clock24 = true;
    aggressiveResize = false;
    sensibleOnTop = false;
    keyMode = "vi";
    terminal = "screen-256color";
    shell = "${pkgs.zsh}/bin/zsh";

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.tmux-fzf;
        extraConfig = ''
          bind-key "l" run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/window.sh switch"
        '';
      }
      # idk, i don't use it tbh
      #{
      #  plugin = tmuxPlugins.resurrect;
      #  extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      #}

      # dunno, this doesn't seem to work (yet)
      # {
      #   plugin = tmuxPlugins.continuum;
      #   extraConfig = ''
      #     set -g @continuum-restore 'on'
      #     set -g @continuum-save-interval '15' # minutes
      #   '';
      # }
    ];

    extraConfig = ''
      set -g mouse on
    '';
  };
}

