{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        font = "Iosevka Nerd Font Mono 16";
        frame_color = "#89B4FA";
        separator_color = "frame";
      };

      urgency_low = {

        background = "#1E1E2E";
        foreground = "#CDD6F4";
      };

      urgency_normal = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        timeout = 10;
      };

      urgency_critical = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        frame_color = "#FAB387";
      };

    };
  };
}
