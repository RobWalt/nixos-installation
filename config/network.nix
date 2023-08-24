{ inputs, ... }:
let inherit (inputs) hostName; in
{
  networking = {
    inherit hostName; # machine host name

    useDHCP = false;

    # interfaces
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;

    networkmanager.enable = true;

    firewall = {
      enable = true;

      # open ports
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPortRanges = [
        { from = 4000; to = 4007; }
        { from = 8000; to = 8010; }
      ];

      # To allow connections from a local network over specific ports
      interfaces."wlp3s0".allowedTCPPorts = [ 8000 ];
    };
  };
}
