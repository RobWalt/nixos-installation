{ pkgs, config, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.robw = {

    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; })
    ];

    programs.home-manager.enable = true;

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

    programs.git = {
      enable = true;
      userName = "RobWalt";
      userEmail = "robwalter96@gmail.com";
      extraConfig = {
        pull.rebase = false;
      };
    };

    programs.alacritty = {
      enable = true;
      settings = { };
    };

    services.polybar =
      let
        homepolybar = pkgs.polybar.override {
          i3Support = true;
        };
      in
      {
        enable = true;
        package = homepolybar;
        script = ''
          polybar main --config=/home/robw/.config/polybar/config
        '';
        config = {
          "global/wm" = {
            margin-bottom = 0;
            margin-top = 0;
          };
          "bar" = {
            fill = "絛";
            empty = "絛";
            indicator = "雷";
          };
          "module/battery" = {
            type = "internal/battery";
            full-at = 99;
            battery = "BAT1";
            adapter = "ACAD";
            poll-interval = 2;
            time-format = "%H:%M";
            format-charging = "<animation-charging> <label-charging>";
            format-charging-background = "\${color.shade5}";
            format-charging-padding = 2;
            format-discharging = "<ramp-capacity> <label-discharging>";
            format-discharging-background = "\${color.shade5}";
            format-discharging-padding = 2;
            format-full = "<label-full>";
            format-full-prefix = "";
            format-full-background = "\${color.shade5}";
            format-full-padding = 2;
            label-charging = "%percentage%%";
            label-discharging = "%percentage%%";
            label-full = " Full";
            ramp-capacity-0 = "";
            ramp-capacity-1 = "";
            ramp-capacity-2 = "";
            ramp-capacity-3 = "";
            ramp-capacity-4 = "";
            ramp-capacity-5 = "";
            ramp-capacity-6 = "";
            ramp-capacity-7 = "";
            ramp-capacity-8 = "";
            ramp-capacity-9 = "";
            animation-charging-0 = "";
            animation-charging-1 = "";
            animation-charging-2 = "";
            animation-charging-3 = "";
            animation-charging-4 = "";
            animation-charging-5 = "";
            animation-charging-6 = "";
            animation-charging-framerate = 750;
          };
          "module/date" = {
            type = "internal/date";
            internal = "1.0";
            time = " %a, %d %b %Y - %H:%M";
            format = "<label>";
            format-background = "\${color.shade6}";
            format-padding = 2;
            label = "%time%";
          };
          "module/i3" = {
            type = "internal/i3";
            pin-workspaces = true;

            strip-wsnumbers = true;
            index-sort = true;
            enable-click = false;
            enable-scroll = false;
            wrapping-scroll = false;
            reverse-scroll = false;
            fuzzy-match = true;
            ws-icon-1 = "2;♛";
            ws-icon-2 = "3;♜";
            ws-icon-3 = "4;♝";
            ws-icon-4 = "5;♞";
            ws-icon-default = "♟";
            format = "<label-state> <label-mode>";
            label-mode = "%mode%";
            label-mode-padding = 2;
            label-mode-background = "#e60053";
            label-focused = "%index%";
            label-focused-foreground = "#ffffff";
            label-focused-background = "#3f3f3f";
            label-focused-underline = "\${color.shade8}";
            label-focused-padding = 2;
            label-unfocused = "%index%";
            label-unfocused-padding = 2;
            label-visible = "%index%";
            label-visible-underline = "\${color.foreground-alt}";
            label-visible-padding = 2;
            label-urgent = "%index%";
            label-urgent-foreground = "#000000";
            label-urgent-background = "#bd2c40";
            label-urgent-padding = 2;
          };
          "module/network" = {
            type = "internal/network";
            interface = "wlp1s0";
            interval = "1.0";
            accumulate-stats = true;
            unknown-as-up = true;
            format-connected = "<ramp-signal> <label-connected>";
            format-connected-background = "\${color.shade6}";
            format-connected-padding = 2;
            format-disconnected = "<label-disconnected>";
            format-disconnected-prefix = "睊";
            format-disconnected-background = "\${color.shade4}";
            format-disconnected-padding = 2;
            label-connected = "%essid%";
            label-disconnected = "Offline";
            ramp-signal-0 = "直";
            ramp-signal-1 = "直";
            ramp-signal-2 = "直";
          };
          "color" = {
            background = "#282828";
            foreground = "#ebdbb2";
            foreground-alt = "#a89984";
            shade1 = "#162736";
            shade2 = "#25425a";
            shade3 = "#345c7e";
            shade4 = "#4376a2";
            shade5 = "#5d90bc";
            shade6 = "#81a9cb";
            shade7 = "#a5c1da";
            shade8 = "#a9dae9";
          };
          "bar/main" = {
            monitor = "";
            monitor-fallback = "";
            monitor-strict = false;
            override-redirect = false;
            bottom = false;
            fixed-center = true;
            width = "100%";
            height = "3%";
            offset-x = "0%";
            offset-y = "0%";
            background = "\${color.background}";
            foreground = "\${color.foreground}";
            radius-top = "0.0";
            radius-bottom = "0.0";
            underline-size = 2;
            underline-color = "\${color.foreground}";
            border-size = 0;
            border-color = "\${color.background}";
            padding = 0;
            module-margin-left = 0;
            module-margin-right = 0;

            font-0 = "Fantasque Sans Mono:pixelsize=13;3";
            font-1 = "Meslo Nerd Font:pixelsize=13;3";
            modules-left = "i3";
            modules-center = "date";
            modules-right = "battery network";
            separator = "";
            dim-value = "1.0";
            wm-name = "";
            locale = "";
            tray-position = "none";
            tray-detached = false;
            tray-maxsize = 16;
            tray-background = "\${color.background}";
            tray-offset-x = 0;
            tray-offset-y = 0;
            tray-padding = 0;
            tray-scale = "1.0";
            dpi = 170;
            enable-ipc = true;
            click-left = "";
            click-middle = "";
            click-right = "";
            scroll-up = "";
            scroll-down = "";
            double-click-left = "";
            double-click-middle = "";
            double-click-right = "";
            cursor-click = "";
            cursor-scroll = "";
          };
          "settings" = {
            throttle-output = 5;
            throttle-output-for = 10;
            screenchange-reload = false;
            compositing-background = "source";
            compositing-foreground = "over";
            compositing-overline = "over";
            compositing-underline = "over";
            compositing-border = "over";
            pseudo-transparency = false;
          };
        };
      };

  };
}
