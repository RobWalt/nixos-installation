{ pkgs, lib, ... }:
let
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
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = false;

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (
        plugins: with pkgs.tree-sitter-grammars; [
          tree-sitter-rust
          tree-sitter-nix
          tree-sitter-lua
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

    extraConfig =
      let
        listOfContent = map lib.readFile [
          ../neovim/general.lua
          ../neovim/colorscheme.lua
          ../neovim/colorizer.lua
          ../neovim/cmp.lua
          ../neovim/dressing.lua
          ../neovim/hlargs.lua
          ../neovim/lsp.lua
          ../neovim/lualine.lua
          ../neovim/luatab.lua
          ../neovim/todo-highlight.lua
          ../neovim/indent-blankline.lua
          ../neovim/nvim-tree.lua
          ../neovim/rust-tools.lua
          ../neovim/toggleterm.lua
          ../neovim/tree-sitter.lua
          ../neovim/keybindings.lua
        ];
      in
      lib.concatStringsSep "\n" listOfContent;
  };
}
