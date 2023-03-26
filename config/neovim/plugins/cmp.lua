lua << EOF
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  local ls = require('luasnip')

  ls.config.set_config{
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  }

  require('luasnip.loaders.from_vscode').lazy_load();
  require('luasnip.loaders.from_vscode').lazy_load({ paths = { "~/.config/nvim/hand_made_snippets" } });

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        ls.lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif ls.expand_or_jumpable() then
          ls.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {'i', 's'}),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif ls.jumpable(-1) then
          ls.jump(-1)
        else
          fallback()
        end
      end, {'i', 's'}),
      ['<C-q>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({select = true}),
    },
    sources = {
      {name = 'nvim_lsp'},
      {name = 'luasnip'},
      {name = 'buffer'},
      {name = 'nvim_lua'},
      {name = 'path'},
      {name = 'crates'},
      {name = 'neorg'},
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      })
    }
  })
EOF
