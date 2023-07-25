{ pkgs, config, ... }:
let
  names = import ../names.nix { };
in
{
  # High DPI settings
  # hardware.video.hidpi.enable = true;

  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    # general settings
    enable = true;

    videoDrivers = [ "amdgpu" ];

    # input
    libinput.enable = true;
    layout = "us";

    displayManager = {
      lightdm.enable = true;
      autoLogin = {
        enable = true;
        user = "${names.userName}";
      };
      defaultSession = "none+i3";
    };

    desktopManager = {
      xterm.enable = false;
    };

    windowManager = {
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        configFile = "/etc/i3.conf";
        extraPackages = builtins.attrValues {
          inherit (pkgs)
            rofi
            feh;
        };
      };
    };
  };

  environment.etc."i3.conf".text = pkgs.callPackage ./i3conf.nix { };

}
