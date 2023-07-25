{ config, pkgs, ... }:
let
  names = import ./names.nix { };
in
{
  imports =
    [
      ./env
      ./hardware/e15.nix
      ./home
      ./neovim
      ./settings.nix
      ./system-packages
      ./windowmanager
    ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";

  networking = {
    hostName = names.hostName; # Define your hostname.
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPortRanges = [
        { from = 4000; to = 4007; }
        { from = 8000; to = 8010; }
      ];

      # To allow connections from a local network
      #interfaces."wlp3s0".allowedTCPPorts = [ 8000 ];
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  };

  fonts.fonts =
    let
      myfonts = pkgs.nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" "Meslo" ]; };
    in
    builtins.attrValues {
      inherit (pkgs)
        terminus_font
        corefonts;
      inherit myfonts;
    };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.${names.userName} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" "realtime" "docker" ];
    };
  };

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *   ${names.userName}  DISPLAY=:0 feh --bg-max /home/${names.userName}/wallpaper/bg/ -z --image-bg \"#345\""
    ];
  };
  services.logind.extraConfig = "RuntimeDirectorySize=4G";

  # smart card reading
  services.pcscd.enable = true;
  # do we really need this if we configure it in home manager?
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "23.05";
}
