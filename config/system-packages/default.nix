{ pkgs, unstable, oldpkgs, ... }:
let
  my-stable-pkgs = import ./stable.nix { inherit pkgs; };
  my-old-pkgs = import ./oldpkgs.nix { inherit oldpkgs; };
  my-unstable-pkgs = import ./unstable.nix { inherit unstable; };
  my-haskell-pkgs = import ./haskell.nix { haskellPackages = pkgs.haskellPackages; };
  my-misc-pkgs = import ./misc.nix { inherit pkgs; };
in
{
  environment.systemPackages = builtins.attrValues (
    my-stable-pkgs
    // my-old-pkgs
    // my-haskell-pkgs
    // my-unstable-pkgs
    // my-misc-pkgs
  );
}
