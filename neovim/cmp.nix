{}:
''
  lua << EOF
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local ls = require('luasnip')
    ls.config.set_config{
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = false,
    }
    require('luasnip/loaders/from_vscode').load()
    cmp.setup({
      snippet = {
        expand = function(args)
          ls.lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
        ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<CR>'] = cmp.mapping.confirm({select = true}),
      },
      sources = {
        {name = 'nvim_lua'},
        {name = 'nvim_lsp'},
        {name = 'path'},
        {name = 'luasnip'},
        {name = 'buffer'},
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text', -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
      }
    })
  EOF
''
