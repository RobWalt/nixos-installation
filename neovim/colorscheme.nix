{}:
''
  set background=dark
  colorscheme everforest

  lua << EOF
    require('nvim-web-devicons').setup()
    require('transparent').setup({
      enable = true,
    })
  EOF
''
