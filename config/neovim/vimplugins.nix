{ pkgs, lib, fetchFromGitHub, hlargs-src, yanky-src, ... }:
let
  pluginGit = version: ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = version;
    src = fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
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
      fileContent = pkgs.callPackage path { };
    in
    lib.concatStringsSep "\n" [
      "lua << EOF"
      fileContent
      "EOF"
    ];
in
{
  pluginList = with pkgs.vimPlugins; with lib;
    [
      {
        plugin = zen-mode-nvim;
        config = loadLuaConfig ./plugins/zen-mode.lua;
      }
      {
        plugin = twilight-nvim;
        config = loadLuaConfig ./plugins/twilight.lua;
      }
      # dependency of many things
      plenary-nvim
      popup-nvim

      # LSP
      {
        plugin = nvim-lspconfig;
        config = loadLuaConfig ./plugins/lsp.lua;
      }
      lsp-status-nvim
      lsp_signature-nvim
      lspkind-nvim
      nvim-dap
      {
        plugin = crates-nvim;
        config = loadLuaConfig ./plugins/crates.lua;
      }
      haskell-vim
      {
        plugin = haskell-tools-nvim;
        config = loadLuaConfig ./plugins/haskell-tools.lua;
      }
      {
        plugin = rust-tools-nvim;
        config = loadLuaConfig ./plugins/rust-tools.lua;
      }

      # highlighting stuff
      {
        plugin = (nvim-treesitter.withPlugins
          (
            plugins: with plugins; [
              rust
              haskell
              nix
              lua
              scheme
              wgsl
            ]
          ));
        config = loadLuaConfigNix ./plugins/tree-sitter.nix;
      }
      nvim-treesitter-context
      nvim-treesitter-refactor
      {
        plugin = indent-blankline-nvim;
        config = loadLuaConfig ./plugins/indent-blankline.lua;
      }
      vim-nix
      {
        plugin = vim-illuminate;
        config = loadLuaConfig ./plugins/illuminate.lua;
      }
      nvim-web-devicons
      {
        plugin = nvim-colorizer-lua;
        config = loadLuaConfig ./plugins/colorizer.lua;
      }

      # cmp
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

      # color schemes

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
      telescope-manix
      # doesn't work yet (https://github.com/ndmitchell/hoogle/issues/408)
      # telescope_hoogle
      {
        plugin = telescope-nvim;
        config = loadLuaConfig ./plugins/telescope.lua;
      }
      {
        plugin = lualine-nvim;
        config = loadLuaConfig ./plugins/lualine.lua;
      }
      {
        plugin = luatab-nvim;
        config = loadLuaConfig ./plugins/luatab.lua;
      }
      {
        plugin = nvim-tree-lua;
        config = loadLuaConfig ./plugins/nvim-tree.lua;
      }


      # git
      {
        plugin = diffview-nvim;
        config = loadLuaConfig ./plugins/diffview.lua;
      }
      {
        plugin = neogit;
        config = loadLuaConfig ./plugins/neogit.lua;
      }
      {
        plugin = gitsigns-nvim;
        config = loadLuaConfig ./plugins/gitsigns.lua;
      }

      # other
      {
        plugin = dial-nvim;
        config = loadLuaConfig ./plugins/dial.lua;
      }
      {
        plugin = neoscroll-nvim;
        config = loadLuaConfig ./plugins/neoscroll.lua;
      }
      catppuccin-nvim
      telescope-symbols-nvim
      {
        plugin = dressing-nvim;
        config = loadLuaConfig ./plugins/dressing.lua;
      }
      wgsl-vim

      {
        plugin =
          pkgs.vimUtils.buildVimPluginFrom2Nix {
            pname = "${lib.strings.sanitizeDerivationName "gbprod/yanky.nvim"}";
            version = "flakify";
            src = yanky-src;
          };
        config = loadLuaConfig ./plugins/yanky.lua;
      }
      {
        plugin =
          pkgs.vimUtils.buildVimPluginFrom2Nix {
            pname = "${lib.strings.sanitizeDerivationName "m-demare/hlargs.nvim"}";
            version = "flakify";
            src = hlargs-src;
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
