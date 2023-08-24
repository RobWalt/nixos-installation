{ config, lib, pkgs, inputs, ... }:
let inherit (inputs) adminName; in
{
  # followed a guide with good explanations here 
  # https://rzetterberg.github.io/yubikey-gpg-nixos.html

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      yubikey-personalization# needed here to allow usb connections to yubikeys
      pinentry# passphrase input
      gnupg# key signing
      gpgme# key signing
      pass# password autotyper
      rofi-pass# pass integration for rofi-pass
      ;
  };

  services.udev.packages = builtins.attrValues {
    inherit (pkgs)
      yubikey-personalization# helper program for configuration of yubikeys
      ;
  };

  # smart card reading
  services.pcscd.enable = true;
  # do we really need this if we configure it in home manager?
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Do this once the setup is complete
  #
  # programs.ssh.startAgent = false;
  # environment.shellInit = ''
  #   gpg-connect-agent /bye
  #   export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  # '';

  # Delete this once the above is used
  #
  environment.shellInit = '' 
     eval $(ssh-agent) > /home/${adminName}/.sshstartup.log && ssh-add /home/${adminName}/.ssh/keys/* 2>> /home/${adminName}/.sshstartup.log
   '';
}
