{}:
{
  content = ''
    autocmd BufWritePre *.nix lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)

    lua << EOF
      require('lspconfig').rnix.setup{};
      require('lspconfig').rust_analyzer.setup {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "by_self",
            },
            cargo = {
              loadOutDirsFromCheck = true
            },
            procMacro = {
              enable = true
            },
          }
        }
      }
    EOF
  '';

}
