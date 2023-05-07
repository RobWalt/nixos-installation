{ pkgs, lib, fetchFromGitHub, inputs, ... }:
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
in
{
  myvimplugins = with pkgs.vimPlugins; with lib;
    [
      {
        plugin = zen-mode-nvim;
        config = readFile ./plugins/zen-mode.lua;
      }
      {
        plugin = twilight-nvim;
        config = readFile ./plugins/twilight.lua;
      }
      # dependency of many things
      plenary-nvim
      popup-nvim

      # LSP
      {
        plugin = nvim-lspconfig;
        config = readFile ./plugins/lsp.lua;
      }
      lsp-status-nvim
      lsp_signature-nvim
      lspkind-nvim
      nvim-dap
      {
        plugin = crates-nvim;
        config = readFile ./plugins/crates.lua;
      }
      {
        plugin = rust-tools-nvim;
        config = readFile ./plugins/rust-tools.lua;
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
        config = readFile ./plugins/tree-sitter.lua;
      }
      nvim-treesitter-context
      {
        plugin = indent-blankline-nvim;
        config = readFile ./plugins/indent-blankline.lua;
      }
      vim-nix
      {
        plugin = vim-illuminate;
        config = readFile ./plugins/illuminate.lua;
      }
      nvim-web-devicons
      {
        plugin = nvim-colorizer-lua;
        config = readFile ./plugins/colorizer.lua;
      }

      # cmp
      {
        plugin = nvim-cmp;
        config = readFile ./plugins/cmp.lua;
      }
      cmp-buffer
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp_luasnip
      friendly-snippets
      luasnip

      # color schemes

      # simple better UX
      auto-pairs
      {
        plugin = nvim-comment;
        config = readFile ./plugins/comment.lua;
      }
      {
        plugin = todo-comments-nvim;
        config = readFile ./plugins/todo-highlight.lua;
      }

      # UX apps
      {
        plugin = toggleterm-nvim;
        config = readFile ./plugins/toggleterm.lua;
      }
      {
        plugin = telescope-nvim;
        config = readFile ./plugins/telescope.lua;
      }
      {
        plugin = lualine-nvim;
        config = readFile ./plugins/lualine.lua;
      }
      {
        plugin = luatab-nvim;
        config = readFile ./plugins/luatab.lua;
      }
      {
        plugin = nvim-tree-lua;
        config = readFile ./plugins/nvim-tree.lua;
      }


      # git
      {
        plugin = diffview-nvim;
        config = readFile ./plugins/diffview.lua;
      }
      {
        plugin = neogit;
        config = readFile ./plugins/neogit.lua;
      }
      {
        plugin = gitsigns-nvim;
        config = readFile ./plugins/gitsigns.lua;
      }

      # other
      {
        plugin = dial-nvim;
        config = readFile ./plugins/dial.lua;
      }
      {
        plugin = neoscroll-nvim;
        config = readFile ./plugins/neoscroll.lua;
      }
      catppuccin-nvim
      telescope-symbols-nvim
      {
        plugin = dressing-nvim;
        config = readFile ./plugins/dressing.lua;
      }
      {
        plugin = neorg;
        config = readFile ./plugins/neorg.lua;
      }

      {
        plugin =
          pkgs.vimUtils.buildVimPluginFrom2Nix {
            pname = "${lib.strings.sanitizeDerivationName "gbprod/yanky.nvim"}";
            version = "flakify";
            src = inputs.yanky-src;
          };
        config = readFile ./plugins/yanky.lua;
      }
      {
        plugin =
          pkgs.vimUtils.buildVimPluginFrom2Nix {
            pname = "${lib.strings.sanitizeDerivationName "m-demare/hlargs.nvim"}";
            version = "flakify";
            src = inputs.hlargs-src;
          };
        config = readFile ./plugins/hlargs.lua;
      }
      (
        pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "${lib.strings.sanitizeDerivationName "nvim-neorg/neorg-telescope"}";
          version = "flakify";
          src = inputs.neorg-telescope-src;
        }
      )
      (
        pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "${lib.strings.sanitizeDerivationName "DingDean/wgsl.vim"}";
          version = "flakify";
          src = inputs.wgsl-vim-src;
        }
      )
    ];

  myvimextraconfig =
    let
      listOfContent = map lib.readFile [
        ./general.lua
        ./colorscheme.lua
        ./keybindings.lua
      ];
    in
    lib.concatStringsSep "\n" listOfContent;
}
