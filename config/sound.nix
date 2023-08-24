{ pkgs, inputs, ... }:
let inherit (inputs) adminName; in
{
  # Enable sound.
  sound.enable = true;

  # PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  programs.nm-applet = {
    enable = true;
    indicator = true;
  };

  users.extraUsers.${adminName}.extraGroups = [ "audio" "realtime" ];

  # audio stuff
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      pavucontrol
      qjackctl
      jack2;
  };

}
