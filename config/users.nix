{ pkgs, inputs, ... }:
let inherit (inputs) adminName; in
{
  # Define user accounts. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.${adminName} = {
      isNormalUser = true;
      extraGroups = [
        # wifi
        "networkmanager"
        # ???
        "wheel"
        # pipewire
        "audio"
        # honestly ??? darn...
        "realtime"
        # docker duh
        "docker"
        # podman duh
        "podman"
      ];
    };
  };
  programs.zsh.enable = true;
}
