{ inputs, ... }:
let inherit (inputs) adminName; in
{
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  users.users.${adminName}.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNhTYdS+6AhS9WHNejnMXtmoMI5+zifxjkkQttzDx3SGIJPxgEkKFNwG5GGKJDGZUU7XaF7oB7ZaWMxoFs5GPU0= openpgp:0x85C58B45" # content of authorized_keys file
    # note: ssh-copy-id will add user@clientmachine after the public key
    # but we can remove the "@clientmachine" part
  ];
}
