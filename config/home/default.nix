{ pkgs, config, lib, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz";
    sha256 = "1gf97qpywcr6ckvwah3j5szrjl1xhv99w5jkbw2nlhj6w7j29cns";
  };
  hoard-shell-plugin-path = builtins.fetchurl "https://raw.githubusercontent.com/Hyde46/hoard/main/src/shell/hoard.zsh";
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

      home.file.".cargo/config.toml".text = pkgs.callPackage ./home-configs/cargo-config.nix { };
      home.file.".config/nvim/hand_made_snippets/package.json".text = lib.readFile ./home-configs/vim-snippets/package.json;
      home.file.".config/nvim/hand_made_snippets/rust/bevy.json".text = lib.readFile ./home-configs/vim-snippets/rust/bevy.json;
      home.file.".config/nvim/hand_made_snippets/rust/functional.json".text = lib.readFile ./home-configs/vim-snippets/rust/functional.json;
      home.file.".config/nvim/hand_made_snippets/rust/general.json".text = lib.readFile ./home-configs/vim-snippets/rust/general.json;
      home.file.".config/nvim/hand_made_snippets/all.json".text = lib.readFile ./home-configs/vim-snippets/all.json;
      home.file.".config/hoard/hoard.zsh".text = lib.readFile hoard-shell-plugin-path;

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
          push.autoSetupRemote = true;
        };
      };

    };
}
