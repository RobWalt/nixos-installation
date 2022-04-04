{}:
''
  lua << EOF
    vim.opt.termguicolors = true
    vim.cmd [[highlight IndentBlanklineIndent1 guifg=#3b4349 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent2 guifg=#434b51 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent3 guifg=#4b5359 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent4 guifg=#535b60 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent5 guifg=#5b6369 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent6 guifg=#636b70 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent7 guifg=#6b7379 gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineIndent8 guifg=#737b80 gui=nocombine]]
    
    require("indent_blankline").setup {
        char_highlight_list = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
            "IndentBlanklineIndent7",
            "IndentBlanklineIndent8",
        },
    }
  EOF
''
