{}:
''
  lua << EOF
    require('nvim-treesitter.configs').setup {
      ensure_installed = {"nix", "rust"},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  EOF
''
