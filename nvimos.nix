{ pkgs, ... }:
let
  nvimos = pkgs.writeShellScriptBin "nvimos" '' 
  alacritty msg create-window -e nvim $HOME;
  '';
in
{
  environment.systemPackages = [ nvimos ];
}
