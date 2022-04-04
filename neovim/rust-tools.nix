{}:
''
  lua << EOF
    require('rust-tools').setup({

      tools = {
        autoSetHints = true,
        hover_with_actions = true,
        executor = require("rust-tools/executors").termopen,
        on_initialized = nil,
        inlay_hints = {
          only_current_line = false,
          only_current_line_autocmd = "CursorHold",
          show_parameter_hints = true,
          show_variable_name = false,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
          highlight = "Comment",
        },
      },
      server = {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        standalone = true,
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "by_self",
            },
            cargo = {
              loadOutDirsFromCheck = true,
            },
            procMacro = {
              enable = true
            },
          }
        }
      },
    })
  EOF

  au! CursorHold * call AutoDiagnosis()
  set updatetime=500
  
  func AutoDiagnosis()
    lua vim.diagnostic.open_float(nil, { focusable = false })
  endfunc
''
