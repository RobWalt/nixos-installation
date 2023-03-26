lua << EOF
  require('nvim-tree').setup {
    diagnostics = {
      enable = true,
    },
    view = {
      mappings = {
        list = {
          { key = "i", action = "split" },
          { key = "s", action = "vsplit" },
        },
      },
    },
    actions = {
      open_file = {
        quit_on_open = true,
      }
    }
  }
EOF
