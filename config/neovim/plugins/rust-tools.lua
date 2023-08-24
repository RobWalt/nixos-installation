vim.g.updatetime = 500
vim.api.nvim_create_autocmd("CursorHold",
  { pattern = { "*" }, command = "lua vim.diagnostic.open_float(nil, { focusable = false })" })

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities = vim.tbl_extend('keep', capabilities or {}, require('lsp-status').capabilities)

local rt = require('rust-tools')
rt.setup({
  tools = {
    executor = require("rust-tools/executors").termopen,
    on_initialized = nil,
    inlay_hints = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
  },
  crate_graph = {
    -- true for all crates.io and external crates, false only the local
    -- crates
    -- default: true
    full = false,
  },
  server = {
    capabilities = capabilities,
    on_attach = function(x, bufnr)
      require('lsp-status').on_attach(x)
      -- Hover actions
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
    end,
    settings = {
      ["rust-analyzer"] = {
        imports = {
          prefix = "crate",
          granularity = {
            group = "module"
          },
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
          extraArgs = { "+nightly" },
        },
        checkOnSave = {
          command = "clippy",
          -- extraArgs = {"--", "-W", "clippy::all", "-W", "clippy::pedantic"},
        }
      }
    }
  },
})
