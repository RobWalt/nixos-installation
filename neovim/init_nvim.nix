{ pkgs, ... }:
let
  unstable = import <nixos-unstable> { };
in
{
  nixpkgs.overlays =
    let
      # function to reduce redundancy
      neovim_pwd = builtins.toString ./.;
      settings_fn = name: (import "${neovim_pwd}/${name}_settings.nix" { }).content;

      # init.nvim parts
      general_settings = settings_fn "general";
      cmp_settings = settings_fn "cmp";
      colorscheme_settings = settings_fn "colorscheme";
      lsp_settings = settings_fn "lsp";
      nerdtree_settings = settings_fn "nerdtree";
      rusttools_settings = settings_fn "rusttools";
      toggleterm_settings = settings_fn "toggleterm";
      treesitter_settings = settings_fn "treesitter";
      keybindings = settings_fn "keybindings";
    in
    [
      (self: super: {
        neovim = unstable.neovim.override {
          viAlias = true;
          vimAlias = true;
          configure = {
            plug.plugins = with pkgs.vimPlugins;
              [
                auto-pairs
                cmp-buffer
                cmp-nvim-lsp
                cmp-vsnip
                ctrlp-vim
                gruvbox
                nerdtree
                nvim-cmp
                nvim-dap
                nvim-lspconfig
                nvim-treesitter
                plenary-nvim
                popup-nvim
                rust-tools-nvim
                telescope-nvim
                toggleterm-nvim
                vim-airline
                vim-airline-themes
                vim-nix
                vim-vsnip
              ];
            customRC =
              general_settings
              + cmp_settings
              + colorscheme_settings
              + lsp_settings
              + nerdtree_settings
              + rusttools_settings
              + toggleterm_settings
              + treesitter_settings
              + keybindings;
          };
        };
      })
    ];

  environment.systemPackages = with pkgs;
    [
      neovim
      clang # needed for rust-tools
      gcc # needed for treesitter compilation
      git # needed for treesitter download
      rnix-lsp # nix lsp
      rust-analyzer # rust lsp
    ];
}
