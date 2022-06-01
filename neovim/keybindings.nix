{}:
''
  " Remap Leader
  let mapleader = ','
  "Key bindings
  nnoremap <silent> <C-f> :NvimTreeFindFileToggle<CR>
  nnoremap <silent> <C-K> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
  nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
  nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gD <cmd>Telescope diagnostics theme=ivy initial_mode=normal<CR>
  nnoremap <silent> gd <cmd>Telescope lsp_definitions theme=ivy initial_mode=normal<CR>
  nnoremap <silent> gi <cmd>Telescope lsp_implementations theme=ivy initial_mode=normal<CR>
  nnoremap <silent> gr <cmd>Telescope lsp_references theme=ivy initial_mode=normal<CR>
  nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action() initial_mode=normal<CR>
  nnoremap <silent> <C-q> <cmd>Telescope current_buffer_fuzzy_find theme=cursor<CR>
  nnoremap <silent> <C-g> <cmd>Telescope live_grep<CR>
  nnoremap <silent> <C-s> <cmd>Telescope git_status initial_mode=normal<CR>
  nnoremap <silent> <C-c> <cmd>Telescope git_commits initial_mode=normal<CR>
  nnoremap <silent> <Leader>m <cmd>lua vim.lsp.buf.rename()<CR>
  vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
  nnoremap <silent> <A-,> :tabprevious<CR>
  nnoremap <silent> <A-.> :tabnext<CR>
  nnoremap <silent> <A-h> :tabmove -1<CR>
  nnoremap <silent> <A-l> :tabmove +1<CR>

  nnoremap <silent> <Leader>t <cmd>TodoTelescope<CR>

  inoremap <silent> <C-s> <space><ESC>hi<cmd>lua require("telescope.builtin").symbols({sources = {"math"}})<CR>
  inoremap <silent> <C-d> <space><ESC>hi<cmd>lua require("telescope.builtin").symbols({sources = {"emoji"}})<CR>

  inoremap <silent> <C-k> <cmd> lua if require("luasnip").expand_or_jumpable() then require("luasnip").expand_or_jump() end<CR>
  inoremap <silent> <C-j> <cmd> lua if require("luasnip").jumpable(-1) then require("luasnip").jump(-1) end<CR>
''
