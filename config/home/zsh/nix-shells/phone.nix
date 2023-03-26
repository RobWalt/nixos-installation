# shell.nix

{ pkgs ? import <nixpkgs> { } }:
let
  stable = import <nixos> { };
in
with stable; pkgs.mkShell {
  buildInputs = [
    android-tools
  ];
}
