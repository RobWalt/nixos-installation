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
      lsp_settings = settings_fn "lsp";
      colorscheme_settings = settings_fn "colorscheme";
      nerdtree_settings = settings_fn "nerdtree";
      treesitter_settings = settings_fn "treesitter";
      rusttools_settings = settings_fn "rusttools";
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
                vim-nix
                gruvbox
                rust-tools-nvim
                nvim-lspconfig
                cmp-nvim-lsp
                cmp-buffer
                nvim-cmp
                cmp-vsnip
                vim-vsnip
                plenary-nvim
                nvim-dap
                popup-nvim
                telescope-nvim
                nvim-treesitter
                nerdtree
                auto-pairs
                ctrlp-vim
              ];
            customRC = general_settings
              + cmp_settings
              + lsp_settings
              + colorscheme_settings
              + nerdtree_settings
              + treesitter_settings
              + rusttools_settings
              + keybindings;
          };
        };
      })
    ];

  environment.systemPackages = with pkgs;
    [
      neovim
      gcc # needed for treesitter compilation
      clang # needed for rust-tools
      git # needed for treesitter download
      rnix-lsp # nix lsp
      rust-analyzer # rust lsp
    ];
}
