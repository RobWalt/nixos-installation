{ pkgs, ... }:
{
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
        "color" = {
          everforest-background = "#2b3339";
          everforest-foreground = "#d3c6aa";
          everforest-black = "#323d43";
          everforest-red = "#e67e80";
          everforest-green = "#a7c080";
          everforest-yellow = "#dbbc7f";
          everforest-blue = "#7fbbb3";
          everforest-magenta = "#d699b6";
          everforest-cyan = "#83c092";
          everforest-white = "#d3c6aa";
          everforest-gray = "#4b565c";
          everforest-accent = "#a7c080";
          everforest-urgent = "#dbbc7f";
        };
        "module/battery" = {
          type = "internal/battery";
          full-at = 99;
          battery = "BAT0";
          adapter = "AC";
          poll-interval = 2;
          time-format = "%H:%M";
          format-charging = "<animation-charging> <label-charging>";
          format-charging-background = "\${color.everforest-yellow}";
          format-charging-padding = 2;
          format-discharging = "<ramp-capacity> <label-discharging>";
          format-discharging-background = "\${color.everforest-yellow}";
          format-discharging-padding = 2;
          format-full = "<label-full>";
          format-full-prefix = "";
          format-full-background = "\${color.everforest-green}";
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
          format-background = "\${color.everforest-cyan}";
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
          label-mode-background = "\${color.everforest-background}";
          label-focused = "%index%";
          label-focused-foreground = "\${color.everforest-white}";
          label-focused-background = "\${color.everforest-gray}";
          label-focused-underline = "\${color.everforest-magenta}";
          label-focused-padding = 2;
          label-unfocused = "%index%";
          label-unfocused-padding = 2;
          label-visible = "%index%";
          label-visible-underline = "\${color.everforest-background}";
          label-visible-padding = 2;
          label-urgent = "%index%";
          label-urgent-foreground = "\${color.everforest-foreground}";
          label-urgent-background = "\${color.everforest-urgent}";
          label-urgent-padding = 2;
        };
        "module/network" = {
          type = "internal/network";
          interface = "enp2s0";
          interval = "1.0";
          accumulate-stats = true;
          unknown-as-up = true;
          format-connected-prefix = "";
          format-connected-background = "\${color.everforest-blue}";
          format-connected-padding = 2;
          label-connected = "Down:%downspeed% Up:%upspeed%";
          format-connected = "<label-connected>";
          format-disconnected-prefix = "";
          format-disconnected-background = "\${color.everforest-red}";
          format-disconnected-padding = 2;
          label-disconnected = "Offline";
          format-disconnected = "<label-disconnected>";
        };
        "module/alsa" = {
          type = "internal/alsa";
          interval = "2.0";
          format-volume-background = "\${color.everforest-magenta}";
          format-volume-padding = 2;
          format-volume = "<label-volume> <ramp-volume>";
          label-volume = "%percentage%%";
          label-muted = "(X) muted";
          label-muted-background = "\${color.everforest-magenta}";
          ramp-volume-0 = "|";
          ramp-volume-1 = "||";
          ramp-volume-2 = "|||";
          ramp-volume-3 = "||||";
          ramp-volume-4 = "|||||";
          ramp-volume-5 = "||||||";
          ramp-volume-6 = "|||||||";
          ramp-volume-7 = "||||||||";
          ramp-volume-8 = "|||||||||";
        };
        "module/backlight" = {
          type = "internal/backlight";
          card = "amdgpu_bl0";
          use-actual-brightness = true;
          enable-scroll = false;
          format = "<bar> <label>";
          format-padding = 2;
          format-background = "\${color.everforest-red}";
          label = "%percentage%";
          bar-width = 10;
          bar-indicator = "|";
          bar-fill = "-";
          bar-empty = "-";
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
          background = "\${color.everforest-background}";
          foreground = "\${color.everforest-gray}";
          radius-top = "0.0";
          radius-bottom = "0.0";
          underline-size = 2;
          underline-color = "\${color.everforest-foreground}";
          border-size = 0;
          border-color = "\${color.everforest-foreground}";
          padding = 0;
          module-margin-left = 0;
          module-margin-right = 0;

          font-0 = "Fantasque Sans Mono:pixelsize=8;2";
          font-1 = "Meslo Nerd Font:pixelsize=8;2";
          modules-left = "i3";
          modules-center = "date";
          modules-right = "battery backlight alsa network";
          separator = "";
          dim-value = "1.0";
          wm-name = "";
          locale = "";
          tray-position = "none";
          tray-detached = false;
          tray-maxsize = 16;
          tray-background = "\${color.everforest-background}";
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
}
