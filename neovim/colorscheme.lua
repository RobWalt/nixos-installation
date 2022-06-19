lua << EOF
  vim.o.background = "dark"
  vim.cmd("colorscheme everforest")

  require('nvim-web-devicons').setup()
  require('transparent').setup({
    enable = true,
  })
EOF
