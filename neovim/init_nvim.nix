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
      lualine_settings = settings_fn "lualine";
      luatab_settings = settings_fn "luatab";
      nvimtree_settings = settings_fn "nvimtree";
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
                lualine-nvim
                luatab-nvim
                nord-vim
                nvim-cmp
                nvim-dap
                nvim-lspconfig
                nvim-tree-lua
                nvim-treesitter
                nvim-web-devicons
                plenary-nvim
                popup-nvim
                rust-tools-nvim
                telescope-nvim
                toggleterm-nvim
                vim-highlightedyank
                vim-nix
                vim-vsnip
              ];
            customRC =
              general_settings
              + cmp_settings
              + colorscheme_settings
              + lsp_settings
              + lualine_settings
              + luatab_settings
              + nvimtree_settings
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
