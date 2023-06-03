{ pkgs, ... }:
let
  hoard-shell-plugin-path = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Hyde46/hoard/main/src/shell/hoard.zsh";
    sha256 = "sha256:1qbz1csp218nmy2fgkcdq9ryh4zv47grc9q4bfqzpqvrzxgvig4c";
  };
in
{
  # cargo config
  home.file.".cargo/config.toml".text = pkgs.callPackage ../home-configs/cargo-config.nix { };

  # rofi pass config
  home.file.".config/rofi-pass/config".source = ../rofi/rofi-pass.config;

  # snippets for vim
  home.file.".config/nvim/hand_made_snippets/package.json".source = ../home-configs/vim-snippets/package.json;
  home.file.".config/nvim/hand_made_snippets/rust/bevy.json".source = ../home-configs/vim-snippets/rust/bevy.json;
  home.file.".config/nvim/hand_made_snippets/rust/functional.json".source = ../home-configs/vim-snippets/rust/functional.json;
  home.file.".config/nvim/hand_made_snippets/rust/general.json".source = ../home-configs/vim-snippets/rust/general.json;
  home.file.".config/nvim/hand_made_snippets/all.json".source = ../home-configs/vim-snippets/all.json;

  # hoard config
  home.file.".config/hoard/hoard.zsh".source = hoard-shell-plugin-path;

  # Utility functions for other scripts
  home.file.".mygumscripts/utils.sh".source = ../zsh/scripts/glab/utils.sh;

  # ===============================================================
  # There are custom aliases for the stuff below in zsh/default.nix
  # ===============================================================

  # user friendly cli scripts
  home.file.".mygumscripts/glab-info.sh".source = ../zsh/scripts/glab/glab-info.sh;
  home.file.".mygumscripts/glab-status.sh".source = ../zsh/scripts/glab/glab-status.sh;
  home.file.".mygumscripts/glab-mr.sh".source = ../zsh/scripts/glab/glab-mr.sh;
  home.file.".mygumscripts/glab-checklist.sh".source = ../zsh/scripts/glab/glab-checklist.sh;
  home.file.".mygumscripts/git-commit.sh".source = ../zsh/scripts/glab/git-commit.sh;

  # tmux init stuff
  home.file.".tmux/init-tmux-work.sh".source = ../tmux/scripts/init-tmux-work.sh;
  home.file.".tmux/init-tmux-system.sh".source = ../tmux/scripts/init-tmux-system.sh;
  home.file.".tmux/init-tmux-all.sh".source = ../tmux/scripts/init-tmux-all.sh;
  home.file.".tmux/init-tmux-freetime.sh".source = ../tmux/scripts/init-tmux-freetime.sh;

  # nix shell creaters
  home.file.".nix-shells/bevy.nix".source = ../zsh/nix-shells/bevy.nix;
  home.file.".nix-shells/dev.nix".source = ../zsh/nix-shells/dev.nix;
  home.file.".nix-shells/wasm.nix".source = ../zsh/nix-shells/wasm.nix;
  home.file.".nix-shells/phone.nix".source = ../zsh/nix-shells/phone.nix;

  home.file.".config/greenclip.toml".source = ../home-configs/greenclip.toml;
}

