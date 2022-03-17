{ pkgs, ... }:
{
    programs.zsh = {
      enable = true;

      enableAutosuggestions = true;

      shellAliases = {
        l = "ls -l";
        ll = "ls -alh";
        ls = "ls --color=tty";
        grep = "rg";
        find = "fd";
      };

      history = {
        size = 100000;
        path = ".zhistory";
      };

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };

      initExtra = ''
        source /home/robw/.p10k.zsh
      '';
    };
}
