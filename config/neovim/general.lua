vim.g.nocompatible = true
-- unified status line
vim.o.laststatus = 3
-- search related
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
-- background theme
vim.o.background = "dark"
-- clipboard
vim.o.clipboard = "unnamedplus"
-- completion menu options
vim.o.completeopt = "menu,menuone,preview,noinsert,noselect"
-- highlight line where cursor is located
vim.o.cursorline = true
-- hide buffer ?
vim.o.hidden = true
-- shows live what to replace when in search & replace mode
vim.o.inccommand = "split"
-- line number settings
vim.o.number = true
vim.o.relativenumber = true
-- split options
vim.o.splitright = true
vim.o.splitbelow = true
-- use 24bit terminal colors
vim.o.termguicolors = true
-- set window title to current file
vim.o.title = true
-- vim command completion
vim.o.wildmenu = true
-- color column
vim.o.colorcolumn = 120
-- use x spaces instead of tab char
vim.o.expandtab = true
-- shift and tab widths
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
-- use same indent on next line as on current line
vim.o.autoindent = true

-- recommendations from nvim-tree
-- -- disable netrw at the very start of your init.lua
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
