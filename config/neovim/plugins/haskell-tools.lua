function HaskToolSetup()
  -- Your Lua code goes here
  local ht = require('haskell-tools')
  local def_opts = { noremap = true, silent = true }
  ht.start_or_attach {
    hls = {
      -- on_attach = function(bufnr)
      --   local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr })
      --   -- haskell-language-server relies heavily on codeLenses,
      --   -- so auto-refresh (see advanced configuration) is enabled by default

      --   -- keymaps and function don't work
      --   vim.keymap.set('n', 'gca', vim.lsp.codelens.run, opts)
      --   vim.keymap.set('n', 'gea', ht.lsp.buf_eval_all, opts)

      --   -- keymap doesnt work and hoogle doesnt work aswell
      --   vim.keymap.set('n', 'gs', ht.hoogle.hoogle_signature, opts)
      -- end,
      settings = {
        haskell = {
          formattingProvider = "ormolu"
        }
      }
    },
  }

  -- Suggested keymaps that do not depend on haskell-language-server:
  local bufnr = vim.api.nvim_get_current_buf()
  -- set buffer = bufnr in ftplugin/haskell.lua
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Toggle a GHCi repl for the current package
  vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
  -- Toggle a GHCi repl for the current buffer
  vim.keymap.set('n', '<leader>rf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
  end, def_opts)
  vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)

  -- Detect nvim-dap launch configurations
  -- (requires nvim-dap and haskell-debug-adapter)
  ht.dap.discover_configurations(bufnr)
end

-- Register the autocommand using the Neovim Lua API
vim.api.nvim_exec([[
  augroup HaskellAutocommands
    autocmd!
    autocmd BufEnter *.hs lua HaskToolSetup()
  augroup END
]], false)
