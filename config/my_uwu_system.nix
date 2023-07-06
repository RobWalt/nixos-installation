{ config, pkgs, inputs, ... }:
{
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  imports =
    [
      ./env
      ./hardware/e15.nix
      ./home
      ./windowmanager
      ./system-packages
      ./neovim
    ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";

  networking = {
    hostName = "robw"; # Define your hostname.
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
    networkmanager.enable = true;
    # firewall = {
    #   enable = true;
    #   allowedTCPPorts = [ 80 443 ];
    #   allowedUDPPortRanges = [
    #     { from = 4000; to = 4007; }
    #     { from = 8000; to = 8010; }
    #   ];

    #   # To allow connections from a local network
    #   interfaces."wlp3s0".allowedTCPPorts = [ 8000 ];
    # };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
  };

  fonts.fonts = with pkgs; [
    terminus_font
    corefonts
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" "Meslo" ]; })
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.robw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "realtime" "docker" ];
  };

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/5 * * * *   robw  DISPLAY=:0 feh --bg-max /home/robw/wallpaper/bg/ -z --image-bg \"#345\""
    ];
  };
  services.logind.extraConfig = "RuntimeDirectorySize=4G";

  # needed for gnupg
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.zsh.enable = true;

  virtualisation.docker.enable = true;

  system.stateVersion = "22.11";

}
