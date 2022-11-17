{ pkgs, lib, ... }:
let
  unstable = import <nixos-unstable> { };
in
{
  programs.neovim = {

    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = false;

    plugins = (pkgs.callPackage ../vimplugins.nix { }).myvimplugins;

    extraConfig = (pkgs.callPackage ../vimplugins.nix { }).myvimextraconfig;
  };
}
