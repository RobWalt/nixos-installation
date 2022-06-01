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
      ./neovim/neovim.nix
    ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Berlin";

  networking = {
    hostName = "robw"; # Define your hostname.
    useDHCP = false;
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "de-latin1";
  };

  fonts.fonts = with pkgs; [
    terminus_font
    corefonts
    (pkgs.nerdfonts.override { fonts = [ "Meslo" "Iosevka" ]; })
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.robw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker" "adbusers" ];
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "21.11"; # Did you read the comment?

}

