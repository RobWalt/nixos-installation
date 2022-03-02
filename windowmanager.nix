{ pkgs, config, ... }:
{
  # High DPI settings
  hardware.video.hidpi.enable = true;

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
      extraPackages = with pkgs; [
        rofi
      ];
    };
  };

  environment.etc."i3.conf".text = pkgs.callPackage ./i3conf.nix { };

}
