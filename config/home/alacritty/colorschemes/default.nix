{}:
{
  latte = import ./latte.nix { };
  frappe = import ./frappe.nix { };
  macchiato = import ./macchiato.nix { };
  mocha = import ./mocha.nix { };
}
