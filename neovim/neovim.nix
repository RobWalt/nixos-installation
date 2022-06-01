{ pkgs, config, lib, ... }:
let
  unstable = import <nixos-unstable> { };
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
  plugin = pluginGit "HEAD";
in
{
  nixpkgs.overlays =
    let
      general = pkgs.callPackage ./general.nix { };
      colorscheme = pkgs.callPackage ./colorscheme.nix { };
      colorizer = pkgs.callPackage ./colorizer.nix { };
      cmp = pkgs.callPackage ./cmp.nix { };
      dressing = pkgs.callPackage ./dressing.nix { };
      hlargs = pkgs.callPackage ./hlargs.nix { };
      lsp = pkgs.callPackage ./lsp.nix { };
      lualine = pkgs.callPackage ./lualine.nix { };
      luatab = pkgs.callPackage ./luatab.nix { };
      todo-highlight = pkgs.callPackage ./todo-highlight.nix { };
      indent-blankline = pkgs.callPackage ./indent-blankline.nix { };
      nvim-tree = pkgs.callPackage ./nvim-tree.nix { };
      rust-tools = pkgs.callPackage ./rust-tools.nix { };
      toggleterm = pkgs.callPackage ./toggleterm.nix { };
      telescope = pkgs.callPackage ./telescope.nix { };
      tree-sitter = pkgs.callPackage ./tree-sitter.nix { };
      keybindings = pkgs.callPackage ./keybindings.nix { };
    in
    [
      (self: super: {
        neovim = unstable.neovim.override {
          viAlias = true;
          vimAlias = true;

          configure = {
            plug.plugins = with pkgs.vimPlugins;
              [
                (nvim-treesitter.withPlugins (
                  plugins: with pkgs.tree-sitter-grammars; [
                    tree-sitter-rust
                    tree-sitter-nix
                  ]
                ))
                (plugin "m-demare/hlargs.nvim")
                (plugin "nvim-telescope/telescope-symbols.nvim")
                (plugin "sainnhe/everforest")
                (plugin "stevearc/dressing.nvim")
                (plugin "xiyaowong/nvim-transparent")
                auto-pairs
                cmp-buffer
                cmp-nvim-lsp
                cmp-nvim-lua
                cmp-path
                luasnip
                friendly-snippets
                cmp_luasnip
                indent-blankline-nvim
                lsp_signature-nvim
                lspkind-nvim
                lsp-status-nvim
                lualine-nvim
                luatab-nvim
                nvim-cmp
                nvim-colorizer-lua
                nvim-dap
                todo-comments-nvim
                nvim-lspconfig
                nvim-tree-lua
                nvim-web-devicons
                plenary-nvim
                popup-nvim
                rust-tools-nvim
                telescope-nvim
                toggleterm-nvim
                vim-highlightedyank
                vim-nix
              ];
            customRC = general
              + colorscheme
              + colorizer
              + cmp
              + dressing
              + lsp
              + hlargs
              + lualine
              + luatab
              + indent-blankline
              + nvim-tree
              + rust-tools
              + toggleterm
              + todo-highlight
              + telescope
              + tree-sitter
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
      #rust-analyzer
    ];
}
