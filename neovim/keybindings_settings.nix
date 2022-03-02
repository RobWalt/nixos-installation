{}:
{
  content =
    ''
      nnoremap <silent> <C-d> :NERDTree<CR>
      nnoremap <silent> <C-f> :NERDTreeFind<CR>
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
      nnoremap <silent> <A-,> :BufferPrevious<CR>
      nnoremap <silent> <A-.> :BufferNext<CR>
      nnoremap <silent> <A-ö> :BufferMovePrevious<CR>
      nnoremap <silent> <A-ä> :BufferMoveNext<CR>
      nnoremap <silent> <A-1> :BufferGoto 1<CR>
      nnoremap <silent> <A-2> :BufferGoto 2<CR>
      nnoremap <silent> <A-3> :BufferGoto 3<CR>
      nnoremap <silent> <A-4> :BufferGoto 4<CR>
      nnoremap <silent> <A-5> :BufferGoto 5<CR>
      nnoremap <silent> <A-6> :BufferGoto 6<CR>
      nnoremap <silent> <A-7> :BufferGoto 7<CR>
      nnoremap <silent> <A-8> :BufferGoto 8<CR>
      nnoremap <silent> <A-9> :BufferLast<CR>
      nnoremap <silent> <A-c> :BufferClose<CR>
      nnoremap <silent> <A-ü> :BufferPin<CR>
    '';
}
