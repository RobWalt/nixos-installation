# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./env.nix
      ./hardware-configuration.nix
      ./home/home.nix
      ./windowmanager.nix
      ./packages.nix
    ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";

  networking = {
    wireless.enable = true;
    wireless.networks = {
      CoolanXD.pskRaw = "a59a39d392ed3a162784400836235fa155c43c03d48ebfd4b5315852f93f526d";
    };
    #wireless.userControlled.enable = true;
    hostName = "robw"; # Define your hostname.
    useDHCP = false;
    interfaces.wlp1s0.useDHCP = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "de-latin1";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.robw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker" ];
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "21.11"; # Did you read the comment?

}
