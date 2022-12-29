lua << EOF
  vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.nix", "*.rs", "*.lua", "*.hs"}, command = "lua vim.lsp.buf.format()"})

  local sigcfg = {
    doc_lines = 0,
    floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
    hint_enable = true, -- virtual hint enable
    hint_prefix = "",  -- Panda for parameter
  }

  local luacfg = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  }

  local hlscfg = {
    settings = {
      haskell = {
        formattingProvider = "ormolu"
      }
    }
  }

  require('lspconfig').rnix.setup({}) -- nix
  require('lspconfig').hls.setup(hlscfg) -- haskell
  -- require('lspconfig').marksman.setup({}) -- markdown
  require('lspconfig').sumneko_lua.setup(luacfg) -- lua
  require('lsp_signature').setup(sigcfg) -- signatures bottom left

EOF
