{}:
''
  autocmd BufWritePre *.nix lua vim.lsp.buf.formatting_sync(nil, 100)
  autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)
  lua << EOF
    sigcfg = {
      doc_lines = 0,
      floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
      hint_enable = true, -- virtual hint enable
      hint_prefix = "",  -- Panda for parameter
    }
    require('lspconfig').rnix.setup({})
    require('lsp_signature').setup(sigcfg)
  EOF
''
