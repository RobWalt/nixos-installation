# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:
let
  stable = import <nixos> { };
in
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" "amdgpu" "radeon" ];
      enable = true;
      luks.devices = {
        luksroot = {
          device = "/dev/disk/by-uuid/4efa4377-ddcd-4ff3-97b8-637ee1425be8";
          preLVM = true;
        };
      };
    };
    kernelModules = [ "kvm-amd" ];
    # unstable version of kernel
    #kernelPackages = stable.linuxPackages_latest;
    extraModulePackages = [ ];
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/a9546c65-7276-4606-acb2-3e58cf089c70";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/F1F5-3861";
      fsType = "vfat";
    };

  swapDevices = [{
    device = "/dev/disk/by-uuid/c5d69b1f-32ab-4b8c-b82d-e895b804260d";
  }];

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [
        stable.amdvlk
      ];
    };
  };


  # ==== SOUND ====
  # Enable sound.

  # Pulse Audio
  # hardware.pulseaudio = {
  #   enable = true;
  #   package = pkgs.pulseaudioFull;
  # };
  sound.enable = true;

  # PipeWire
  # if this doesn't work, try to change the config in pavucontrol!!!
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

  users.extraUsers.robw.extraGroups = [ "audio" "realtime" ];

  # audio stuff
  environment.systemPackages = with pkgs;
    [
      pavucontrol
      qjackctl
      jack2
    ];

  # ==== BLUETOOTH ====
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}