{}:
{
  content =
    ''
      let NERDTreeQuitOnOpen=1 
      autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.insTabTree() | quit | endif
    '';
}
