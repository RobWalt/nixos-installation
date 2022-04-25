{}:
''
  lua << EOF
    local lspstatus = require("lsp-status")

    lspstatus.config({
      kind_labels = {},
      current_function = true,
      show_filename = true,
      indicator_separator = " ",
      component_separator = " ",
      indicator_errors = "",
      indicator_warnings = "",
      indicator_info = "🛈",
      indicator_hint = "❗",
      indicator_ok = "",
      spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
      status_symbol = "",
      diagnostics = true,
    })

    lspstatus.register_progress()

    require("lualine").setup({
      sections = {
        lualine_x = {
          'filetype'
        },
        lualine_y = {
          'progress',
          'location'
        },
        lualine_z = {
          "require('lsp-status').status()"
        },
      }
    })
  EOF
''
