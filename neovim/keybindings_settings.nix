{}:
{
  content =
    ''
      nnoremap <silent> <C-f> :NvimTreeFindFileToggle<CR>
      nnoremap <silent> <C-K> <cmd>lua vim.lsp.buf.signature_help()<CR>
      nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
      nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
      nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
      nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
      nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
      nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
      nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
      nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>
      vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
      nnoremap <silent> <A-,> :tabprevious<CR>
      nnoremap <silent> <A-.> :tabnext<CR>
    '';
}
