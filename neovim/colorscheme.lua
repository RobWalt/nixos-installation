lua << EOF
  vim.o.background = "dark"
  vim.cmd("colorscheme catppuccin")

  require('nvim-web-devicons').setup()
  require('transparent').setup({
    enable = true,
  })
EOF
