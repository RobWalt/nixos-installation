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
          blend-1 = "#454F55";
          blend-2 = "#3E484E";
          blend-3 = "#384147";
          blend-4 = "#313A40";
        };
        "bar/main" = {
          monitor = "";
          monitor-fallback = "";
          monitor-strict = false;
          override-yellowirect = false;
          bottom = false;
          fixed-center = true;
          width = "100%";
          height = "3%";
          offset-x = "0%";
          offset-y = "0%";
          background = "\${color.everforest-background}";
          foreground = "\${color.everforest-white}";
          radius-top = "0.0";
          radius-bottom = "0.0";
          underline-size = 2;
          underline-color = "\${color.everforest-foreground}";
          border-size = 0;
          border-color = "\${color.everforest-foreground}";
          padding = 0;
          module-margin-left = 0;
          module-margin-right = 0;
          font-0 = "Iosevka Nerd Font:style=Bold:pixelsize=8;2";
          font-1 = "MesloLGL Nerd Font:style=Regular:pixelsize=12;2";
          modules-left = "i3";
          modules-center = "b4 b3 b2 b1 sepmid date sepmid b1 b2 b3 b4";
          modules-right = "b4 b3 b2 b1 sepleft battery sepleft backlight sepleft alsa sepleft network sepleft b1 b2 b3 b4";
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
        "module/sepleft" =
          {
            type = "custom/text";
            content = " ♦ ";
            content-background = "\${color.everforest-gray}";
            content-foreground = "\${color.everforest-white}";
          };
        "module/sepmid" =
          {
            type = "custom/text";
            content = " ♦ ";
            content-background = "\${color.everforest-gray}";
            content-foreground = "\${color.everforest-white}";
          };
        "module/b1" =
          {
            type = "custom/text";
            content = " ";
            content-background = "\${color.blend-1}";
          };
        "module/b2" =
          {
            type = "custom/text";
            content = " ";
            content-background = "\${color.blend-2}";
          };
        "module/b3" =
          {
            type = "custom/text";
            content = " ";
            content-background = "\${color.blend-3}";
          };
        "module/b4" =
          {
            type = "custom/text";
            content = " ";
            content-background = "\${color.blend-4}";
          };
        "module/battery" = {
          type = "internal/battery";
          full-at = 99;
          battery = "BAT0";
          adapter = "AC";
          poll-interval = 2;
          time-format = "%H:%M";
          format-charging = "<animation-charging> <label-charging>";
          format-charging-background = "\${color.everforest-gray}";
          format-charging-padding = 0;
          format-discharging = "<ramp-capacity> <label-discharging>";
          format-discharging-background = "\${color.everforest-gray}";
          format-discharging-padding = 0;
          format-full = "<label-full>";
          format-full-prefix = "";
          format-full-background = "\${color.everforest-gray}";
          format-full-padding = 0;
          label-charging = "%percentage%%";
          label-discharging = "%percentage%%";
          label-full = " Full";
          ramp-capacity-0 = " ";
          ramp-capacity-1 = " ";
          ramp-capacity-2 = " ";
          ramp-capacity-3 = " ";
          ramp-capacity-4 = " ";
          ramp-capacity-5 = " ";
          ramp-capacity-6 = " ";
          ramp-capacity-7 = " ";
          ramp-capacity-8 = " ";
          ramp-capacity-9 = " ";
          animation-charging-0 = " ";
          animation-charging-1 = " ";
          animation-charging-2 = " ";
          animation-charging-3 = " ";
          animation-charging-4 = " ";
          animation-charging-5 = " ";
          animation-charging-6 = " ";
          animation-charging-framerate = 750;
        };
        "module/date" = {
          type = "internal/date";
          internal = "1.0";
          time = " %a, %d %b %Y - %H:%M";
          format = "<label>";
          format-background = "\${color.everforest-gray}";
          format-padding = 0;
          label = "%time%";
        };
        "module/i3" = {
          type = "internal/i3";
          pin-workspaces = true;
          index-sort = true;
          enable-click = false;
          enable-scroll = false;
          wrapping-scroll = false;
          reverse-scroll = false;
          fuzzy-match = true;
          ws-icon-0 = "1;♚";
          ws-icon-1 = "2;♛";
          ws-icon-2 = "3;♜";
          ws-icon-3 = "4;♝";
          ws-icon-4 = "5;♞";
          ws-icon-default = "♟";
          format = "<label-state> <label-mode>";
          label-mode = "%mode%";
          label-mode-padding = 1;
          label-mode-background = "\${color.everforest-background}";
          label-focused = "%icon%";
          label-focused-foreground = "\${color.everforest-white}";
          label-focused-background = "\${color.everforest-gray}";
          label-focused-underline = "\${color.everforest-cyan}";
          label-focused-padding = 1;
          label-unfocused = "%icon%";
          label-unfocused-padding = 1;
          label-unfocused-foreground = "\${color.everforest-gray}";
          label-unfocused-background = "\${color.everforest-background}";
          label-visible = "%icon%";
          label-visible-underline = "\${color.everforest-background}";
          label-visible-padding = 1;
          label-urgent = "%icon%";
          label-urgent-foreground = "\${color.everforest-foreground}";
          label-urgent-background = "\${color.everforest-urgent}";
          label-urgent-padding = 1;
        };
        "module/network" = {
          type = "internal/network";
          interface = "enp2s0";
          interval = "1.0";
          accumulate-stats = true;
          unknown-as-up = true;
          format-connected-prefix = "";
          format-connected-background = "\${color.everforest-gray}";
          format-connected-padding = 0;
          label-connected = "  %downspeed% |   %upspeed%";
          format-connected = "<label-connected>";
          format-disconnected-prefix = "";
          format-disconnected-background = "\${color.everforest-gray}";
          format-disconnected-padding = 0;
          label-disconnected = "Offline";
          format-disconnected = "<label-disconnected>";
        };
        "module/alsa" = {
          type = "internal/alsa";
          interval = "5.0";
          master-soundcard = "default";
          speaker-soundcard = "default";
          headphone-soundcard = "default";
          master-mixer = "Master";

          format-volume = "<ramp-volume> <bar-volume>";
          format-volume-background = "\${color.everforest-gray}";
          format-volume-padding = 0;

          format-muted = "<label-muted>";
          format-muted-prefix = "婢";
          format-muted-background = "\${color.everforest-gray}";
          format-muted-padding = 0;

          label-volume = "%percentage%%";

          label-muted = " Muted";
          label-muted-foreground = "\${color.everforest-background}";

          ramp-volume-0 = "奄";
          ramp-volume-1 = "奔";
          ramp-volume-2 = "墳";

          bar-volume-width = 10;
          bar-volume-gradient = false;

          bar-volume-indicator = "\${bar.indicator}";
          bar-volume-indicator-foreground = "\${color.everforest-white}";

          bar-volume-fill = "\${bar.fill}";
          bar-volume-foreground-0 = "\${color.everforest-white}";
          bar-volume-foreground-1 = "\${color.everforest-white}";
          bar-volume-foreground-2 = "\${color.everforest-white}";

          bar-volume-empty = "\${bar.empty}";
          bar-volume-empty-foreground = "\${color.everforest-background}";
          ramp-headphones-0 = "";
        };
        "module/backlight" = {

          type = "internal/backlight";

          card = "amdgpu_bl0";

          format = "<ramp> <bar>";
          format-background = "\${color.everforest-gray}";
          format-padding = 0;

          label = "%percentage%%";

          ramp-0 = " ";
          ramp-1 = " ";
          ramp-2 = " ";
          ramp-3 = " ";
          ramp-4 = " ";

          bar-width = 10;
          bar-gradient = false;

          bar-indicator = "\${bar.indicator}";
          bar-indicator-foreground = "\${color.everforest-white}";

          bar-fill = "\${bar.fill}";
          bar-foreground-0 = "\${color.everforest-white}";
          bar-foreground-1 = "\${color.everforest-white}";
          bar-foreground-2 = "\${color.everforest-white}";

          bar-empty = "\${bar.empty}";
          bar-empty-foreground = "\${color.everforest-background}";

          use-actual-brightness = true;
          enable-scroll = false;
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
