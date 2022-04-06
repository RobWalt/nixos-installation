{ pkgs, config, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.users.robw = { ... }:
    {
      imports = [
        ./polybar.nix
        ./zsh.nix
        ./alacritty.nix
        # ./neovim.nix
      ];

      programs.home-manager.enable = true;

      programs.rofi = {
        enable = true;
        theme = builtins.toString (pkgs.writeText "rofi-theme" ''
          configuration {
              font: "Iosevka Nerd Font Mono";

              drun {
                display-name: " ";
              }

              run {
                display-name: " ";
              }

              window {
                display-name: " ";
              }

              timeout {
                delay: 10;
                action: "kb-cancel";
              }
            }

            * {
              border: 0;
              margin: 0;
              padding: 0;
              spacing: 0;

              bg: #2B3339;
              bg-alt: #323D43;
              fg: #D3C6AA;
              fg-alt: #454F55;

              background-color: @bg;
              text-color: @fg;
            }

            window {
              transparency: "real";
            }

            mainbox {
              border: 5;
              border-color: @fg;
              children: [inputbar, listview];
            }

            inputbar {
              border: 0 0 5 0;
              border-color: @fg;
              background-color: @bg-alt;
              children: [textbox-prompt-sep, entry];
            }

            textbox-prompt-sep {
              expand: false;
              str: "  ";
              background-color: inherit;
              margin: 7px 0 0 0;
            }

            entry {
              background-color: inherit;
              padding: 12px 3px;
            }

            prompt {
              background-color: inherit;
              padding: 12px;
            }

            listview {
              lines: 8;
            }

            element {
              padding: 0 0 12px 0;
              children: [element-text];
            }

            element selected {
              border: 1;
              border-color: @fg;
              background-color: @fg-alt;
            }

            element-text {
              padding: 10px 15px;
              text-color: @fg-alt;
            }

            element-text selected {
              text-color: @fg;
              background-color: @fg-alt;
            }
        '');
      };

      programs.git = {
        enable = true;
        userName = "RobWalt";
        userEmail = "robwalter96@gmail.com";
        extraConfig = {
          pull.rebase = false;
          merge.tool = "nvimdiff";
        };
      };

    };
}
