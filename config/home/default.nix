{ pkgs, config, lib, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.users.robw = { ... }:
    {
      home.stateVersion = config.system.stateVersion;

      imports = [
        ./alacritty.nix
        ./dunst.nix
        ./rofi.nix
        ./tmux
        ./neovim.nix
        ./zsh
      ];

      home.sessionPath = [
        "$HOME/.cargo/bin"
        "$HOME/.local/bin"
      ];

      programs.home-manager.enable = true;

      # home.file.".local/bin/marksman" = {
      #   source = builtins.fetchurl {
      #     url = "https://github.com/artempyanykh/marksman/releases/download/2022-09-13/marksman-linux";
      #     sha256 = "0c7zqhfbn6675f7rj11if306hg6qx97jcr6wlpmn553a8viqr6nm";
      #   };
      #   executable = true;
      # };

      home.file.".cargo/config.toml".text = pkgs.callPackage ./home-configs/cargo-config.nix { };

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
	  init.defaultBranch = "main";
        };
      };

    };
}
