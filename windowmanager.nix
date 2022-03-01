{ pkgs, config, ... }:
{
  # High DPI settings
  hardware.video.hidpi.enable = true;
  services.xserver.dpi = 190;
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2.0";
  };

  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    # general settings
    enable = true;

    # input
    libinput.enable = true;
    layout = "de";

    displayManager = {
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "robw";
      };
      defaultSession = "none+i3";
    };

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      configFile = "/etc/i3.conf";
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };

  environment.etc."i3.conf".text = pkgs.callPackage ./i3conf.nix { };

}
