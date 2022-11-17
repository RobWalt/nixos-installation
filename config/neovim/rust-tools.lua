lua << EOF

  vim.g.updatetime = 500
  vim.api.nvim_create_autocmd("CursorHold", {pattern = {"*"}, command = "lua vim.diagnostic.open_float(nil, { focusable = false })"})

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities = vim.tbl_extend('keep', capabilities or {}, require('lsp-status').capabilities)
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
      capabilities = capabilities,
      on_attach = require('lsp-status').on_attach,
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
            enable = true,
          },
          diagnostics = {
            disabled = {
              "unresolved-proc-macro",
	      "inactive-code"
            },
          },
	  lens = {
	    enable = true,
	    references = { 
	      enable = true, 
	      adt = { enable = true },
	      enumVariant = { enable = true },
	      method = { enable = true },
	      trait = { enable = true },
     	    },
	  },
          rustfmt = {
            extraArgs = {"+nightly"},
          },
          checkOnSave = {
            command = "clippy",
            -- extraArgs = {"--", "-W", "clippy::all", "-W", "clippy::pedantic"},
          }
        }
      }
    },
  })
EOF
