{ pkgs, unstable, lib, fetchFromGitHub, inputs, ... }:
let
  pluginGit = version: ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    inherit version;
    pname = "${lib.strings.sanitizeDerivationName repo}";
    src = fetchGit {
      inherit ref;
      url = "https://github.com/${repo}.git";
    };
  };
  plugin = pluginGit "HEAD" "HEAD";
  loadLuaConfig = path: lib.concatStringsSep "\n" [
    "lua << EOF"
    (lib.readFile path)
    "EOF"
  ];
  loadLuaConfigNix = path:
    let
      fileContent = pkgs.callPackage path { inherit (inputs) adminName; };
    in
    lib.concatStringsSep "\n" [
      "lua << EOF"
      fileContent
      "EOF"
    ];
in
{
  pluginList = with unstable.vimPlugins; with lib;
    [
      # not used much, hence queued for deletion

      #{
      #  plugin = zen-mode-nvim;
      #  config = loadLuaConfig ./plugins/zen-mode.lua;
      #}
      #{
      #  plugin = twilight-nvim;
      #  config = loadLuaConfig ./plugins/twilight.lua;
      #}

      # debug adapter
      #nvim-dap

      # git
      #{
      #  plugin = diffview-nvim;
      #  config = loadLuaConfig ./plugins/diffview.lua;
      #}
      #{
      #  plugin = neogit;
      #  config = loadLuaConfig ./plugins/neogit.lua;
      #}
      #{
      #  plugin = gitsigns-nvim;
      #  config = loadLuaConfig ./plugins/gitsigns.lua;
      #}

      # ============= END removed plugins ==================

      # basic dependencies
      plenary-nvim
      popup-nvim

      # LSP
      {
        # a lot of lsps are so cutting edge that stable isn't enough here
        plugin = nvim-lspconfig;
        config = loadLuaConfig ./plugins/lsp.lua;
      }
      lsp-status-nvim
      lsp_signature-nvim
      lspkind-nvim
      {
        plugin = null-ls-nvim;
        config = loadLuaConfig ./plugins/null-ls.lua;
      }


      # language plugins
      haskell-vim
      wgsl-vim
      vim-nix
      {
        plugin = haskell-tools-nvim;
        config = loadLuaConfig ./plugins/haskell-tools.lua;
      }
      {
        plugin = rust-tools-nvim;
        config = loadLuaConfig ./plugins/rust-tools.lua;
      }
      {
        plugin = crates-nvim;
        config = loadLuaConfig ./plugins/crates.lua;
      }

      # tree-sitter
      {
        plugin = nvim-treesitter.withPlugins
          (
            plugins: with plugins; [
              rust
              haskell
              nix
              lua
              scheme
              wgsl
            ]
          );
        config = loadLuaConfigNix ./plugins/tree-sitter.nix;
      }
      nvim-treesitter-context
      nvim-treesitter-refactor

      # highlighting etc.
      {
        plugin = indent-blankline-nvim;
        config = loadLuaConfig ./plugins/indent-blankline.lua;
      }
      {
        plugin = vim-illuminate;
        config = loadLuaConfig ./plugins/illuminate.lua;
      }
      nvim-web-devicons
      catppuccin-nvim
      {
        plugin = nvim-colorizer-lua;
        config = loadLuaConfig ./plugins/colorizer.lua;
      }

      # autocomplete and snippets
      {
        plugin = nvim-cmp;
        config = loadLuaConfig ./plugins/cmp.lua;
      }
      cmp-buffer
      cmp-nvim-lsp
      cmp-nvim-lua
      cmp-path
      cmp_luasnip
      friendly-snippets
      luasnip

      # simple better UX
      auto-pairs
      {
        plugin = nvim-comment;
        config = loadLuaConfig ./plugins/comment.lua;
      }
      {
        plugin = todo-comments-nvim;
        config = loadLuaConfig ./plugins/todo-highlight.lua;
      }

      # UX apps
      {
        plugin = toggleterm-nvim;
        config = loadLuaConfig ./plugins/toggleterm.lua;
      }

      # telescope

      {
        plugin = telescope-nvim;
        config = loadLuaConfig ./plugins/telescope.lua;
      }
      telescope-manix
      telescope-symbols-nvim
      # doesn't work yet (https://github.com/ndmitchell/hoogle/issues/408)
      # telescope_hoogle

      # status line bottom
      {
        plugin = lualine-nvim;
        config = loadLuaConfig ./plugins/lualine.lua;
      }

      # tabs top
      {
        plugin = luatab-nvim;
        config = loadLuaConfig ./plugins/luatab.lua;
      }

      # file explorer
      {
        plugin = nvim-tree-lua;
        config = loadLuaConfig ./plugins/nvim-tree.lua;
      }

      # enhanced increment/decrement
      {
        plugin = dial-nvim;
        config = loadLuaConfig ./plugins/dial.lua;
      }
      # smooth scrolling
      {
        plugin = neoscroll-nvim;
        config = loadLuaConfig ./plugins/neoscroll.lua;
      }
      # extnsible ui
      {
        plugin = dressing-nvim;
        config = loadLuaConfig ./plugins/dressing.lua;
      }

      {
        plugin =
          pkgs.vimUtils.buildVimPluginFrom2Nix {
            pname = "${lib.strings.sanitizeDerivationName "gbprod/yanky.nvim"}";
            version = "flakify";
            src = inputs.yanky-src;
          };
        config = loadLuaConfig ./plugins/yanky.lua;
      }
      {
        plugin =
          pkgs.vimUtils.buildVimPluginFrom2Nix {
            pname = "${lib.strings.sanitizeDerivationName "m-demare/hlargs.nvim"}";
            version = "flakify";
            src = inputs.hlargs-src;
          };
        config = loadLuaConfig ./plugins/hlargs.lua;
      }
    ];

  extraConfig =
    let
      listOfContent = map loadLuaConfig [
        ./general.lua
        ./colorscheme.lua
        ./keybindings.lua
      ];
    in
    lib.concatStringsSep "\n" listOfContent;
}
