{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./cron.nix
      ./docker.nix
      ./env
      ./fonts.nix
      ./hardware/e15.nix
      ./home
      ./locale.nix
      ./neovim
      ./network.nix
      ./settings.nix
      ./ssh.nix
      ./sound.nix
      ./system-packages
      ./users.nix
      ./windowmanager
      ./yubikey.nix
    ];

  config = {
    system.stateVersion = "23.05";

    # Space for runtime user can get filled up, make it bigger here
    services.logind.extraConfig = "RuntimeDirectorySize=4G";
  };
}
