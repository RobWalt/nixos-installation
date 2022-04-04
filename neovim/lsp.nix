{}:
''
  autocmd BufWritePre *.nix lua vim.lsp.buf.formatting_sync(nil, 100)
  autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)
  lua << EOF
    require('lspconfig').rnix.setup({});
    require('lsp_signature').setup({});
  EOF
''
