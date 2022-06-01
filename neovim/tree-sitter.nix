{}:
''
  lua << EOF
    require('nvim-treesitter.configs').setup {
      ensure_installed = {"nix", "rust", "wgsl"},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      ident = {
        enable = true,
      },
    }
  EOF
''
