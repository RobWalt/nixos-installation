{ pkgs, config, lib, ... }:
let
  stable = import <nixos> { };
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
    [
      (self: super: {
        neovim = stable.neovim.override {

          configure = {
            plug.plugins = with pkgs.vimPlugins;
              [
                (nvim-treesitter.withPlugins (
                  plugins: with pkgs.tree-sitter-grammars; [
                    tree-sitter-rust
                    tree-sitter-haskell
                    tree-sitter-nix
                    tree-sitter-lua
                    tree-sitter-scheme
                  ]
                ))
                (plugin "m-demare/hlargs.nvim")
                (plugin "nvim-telescope/telescope-symbols.nvim")
                # color schemes
                (plugin "sainnhe/everforest")

                (plugin "stevearc/dressing.nvim")
                (plugin "xiyaowong/nvim-transparent")
                (plugin "tidalcycles/vim-tidal")
                (plugin "DingDean/wgsl.vim")
                auto-pairs
                cmp-buffer
                cmp-nvim-lsp
                cmp-nvim-lua
                cmp-path
                cmp_luasnip
                friendly-snippets
                indent-blankline-nvim
                lsp-status-nvim
                lsp_signature-nvim
                lspkind-nvim
                lualine-nvim
                luasnip
                luatab-nvim
                nvim-cmp
                nvim-colorizer-lua
                nvim-dap
                nvim-lspconfig
                nvim-tree-lua
                nvim-treesitter-context
                nvim-web-devicons
                plenary-nvim
                popup-nvim
                rust-tools-nvim
                telescope-nvim
                todo-comments-nvim
                toggleterm-nvim
                vim-highlightedyank
                vim-nix
              ];
            customRC =
              let
                listOfContent = map lib.readFile [
                  ./general.lua
                  ./colorscheme.lua
                  ./colorizer.lua
                  ./cmp.lua
                  ./dressing.lua
                  ./hlargs.lua
                  ./lsp.lua
                  ./lualine.lua
                  ./luatab.lua
                  ./todo-highlight.lua
                  ./indent-blankline.lua
                  ./nvim-tree.lua
                  ./rust-tools.lua
                  ./toggleterm.lua
                  ./tree-sitter.lua
                  ./keybindings.lua
                ];
              in
              lib.concatStringsSep "\n" listOfContent;
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
