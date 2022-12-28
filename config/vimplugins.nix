{ pkgs, lib, fetchFromGitHub, ... }:
let
  unstable = import <nixos-unstable> { };
in
{
  myvimplugins = with pkgs.vimPlugins;
    let
      pluginGit = version: ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "${lib.strings.sanitizeDerivationName repo}";
        version = version;
        src = builtins.fetchGit {
          url = "https://github.com/${repo}.git";
          ref = ref;
        };
      };
      plugin = pluginGit "HEAD" "HEAD";
      pluginGitRev = rev: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "${lib.strings.sanitizeDerivationName repo}";
        version = "pinned";
        src = builtins.fetchGit {
          url = "https://github.com/${repo}.git";
          rev = rev;
        };
      };
    in
    with lib;
    [
      {
        plugin = zen-mode-nvim;
        config = readFile ./neovim/zen-mode.lua;
      }
      {
        plugin = twilight-nvim;
        config = readFile ./neovim/twilight.lua;
      }
      # dependency of many things
      plenary-nvim
      popup-nvim

      # LSP
      {
        plugin = nvim-lspconfig;
        config = readFile ./neovim/lsp.lua;
      }
      lsp-status-nvim
      lsp_signature-nvim
      lspkind-nvim
      nvim-dap
      {
        plugin = crates-nvim;
        config = readFile ./neovim/crates.lua;
      }
      {
        plugin = rust-tools-nvim;
        config = readFile ./neovim/rust-tools.lua;
      }

      # highlighting stuff
      {
        plugin = (nvim-treesitter.withPlugins
          (
            plugins: with pkgs.tree-sitter-grammars; [
              tree-sitter-rust
              tree-sitter-haskell
              tree-sitter-nix
              tree-sitter-lua
              tree-sitter-scheme
              tree-sitter-norg
            ]
          ));
        config = readFile ./neovim/tree-sitter.lua;
      }
      nvim-treesitter-context
      {
        plugin = indent-blankline-nvim;
        config = readFile ./neovim/indent-blankline.lua;
      }
      vim-nix
      {
        plugin = vim-illuminate;
        config = readFile ./neovim/illuminate.lua;
      }
      nvim-web-devicons
      {
        plugin = nvim-colorizer-lua;
        config = readFile ./neovim/colorizer.lua;
      }
      {
        plugin = (plugin "m-demare/hlargs.nvim");
        config = readFile ./neovim/hlargs.lua;
      }

      # cmp
      {
        plugin = nvim-cmp;
        config = readFile ./neovim/cmp.lua;
      }
      cmp-buffer
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp_luasnip
      friendly-snippets
      luasnip

      # color schemes
      (plugin "sainnhe/everforest")
      (plugin "catppuccin/nvim")

      # simple better UX
      auto-pairs
      {
        plugin = nvim-comment;
        config = readFile ./neovim/comment.lua;
      }
      {
        plugin = todo-comments-nvim;
        config = readFile ./neovim/todo-highlight.lua;
      }

      # UX apps
      {
        plugin = toggleterm-nvim;
        config = readFile ./neovim/toggleterm.lua;
      }
      {
        plugin = telescope-nvim;
        config = readFile ./neovim/telescope.lua;
      }
      {
        plugin = lualine-nvim;
        config = readFile ./neovim/lualine.lua;
      }
      {
        plugin = luatab-nvim;
        config = readFile ./neovim/luatab.lua;
      }
      {
        plugin = nvim-tree-lua;
        config = readFile ./neovim/nvim-tree.lua;
      }

      (plugin "nvim-telescope/telescope-symbols.nvim")
      {
        plugin = (plugin "stevearc/dressing.nvim");
        config = readFile ./neovim/dressing.lua;
      }

      # git
      {
        plugin = diffview-nvim;
        config = readFile ./neovim/diffview.lua;
      }
      {
        plugin = neogit;
        config = readFile ./neovim/neogit.lua;
      }

      {
        plugin = dial-nvim;
        config = readFile ./neovim/dial.lua;
      }
      {
        plugin = neoscroll-nvim;
        config = readFile ./neovim/neoscroll.lua;
      }
      {
        plugin = (plugin "gbprod/yanky.nvim");
        config = readFile ./neovim/yanky.lua;
      }
      (plugin "nvim-neorg/neorg-telescope")
      {
        plugin = neorg;
        config = readFile ./neovim/neorg.lua;
      }
      {
        plugin = (plugin "sunjon/Shade.nvim");
        config = readFile ./neovim/shade.lua;
      }
      (plugin "tidalcycles/vim-tidal")
      (plugin "DingDean/wgsl.vim")
    ];

  myvimextraconfig =
    let
      listOfContent = map lib.readFile [
        ./neovim/general.lua
        ./neovim/colorscheme.lua
        ./neovim/keybindings.lua
      ];
    in
    lib.concatStringsSep "\n" listOfContent;
}
