{ pkgs, config, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  unstable = import <nixos-unstable> { };
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.users.robw = { ... }:
    {
      imports = [
        ./polybar.nix
        ./zsh.nix
        ./alacritty.nix
        ./rofi.nix
      ];

      programs.home-manager.enable = true;

      programs.git = {
        enable = true;
        userName = "RobWalt";
        userEmail = "robwalter96@gmail.com";
        extraConfig = {
          pull.rebase = false;
          merge.tool = "nvimdiff";
          core.pager = "delta";
          interactive.diffFilter = "delta --color-only";
          delta.navigate = true;
          merge.conflictstyle = "diff3";
          diff.colorMoved = "default";
        };
      };

      # services.picom = {
      #   enable = true;
      #   package = unstable.picom;
      # };

    };
}
