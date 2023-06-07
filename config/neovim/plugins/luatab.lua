local opts = {
  title = function(bufnr)
    local file = vim.fn.bufname(bufnr)
    file = string.gsub(file, "%s+", "")
    local buftype = vim.fn.getbufvar(bufnr, '&buftype')
    local filetype = vim.fn.getbufvar(bufnr, '&filetype')

    if buftype == 'help' then
      return 'help:' .. vim.fn.fnamemodify(file, ':t:r')
    elseif buftype == 'quickfix' then
      return 'quickfix'
    elseif filetype == 'TelescopePrompt' then
      return 'Telescope'
    elseif filetype == 'git' then
      return 'Git'
    elseif filetype == 'fugitive' then
      return 'Fugitive'
    elseif file:sub(file:len() - 2, file:len()) == 'FZF' then
      return 'FZF'
    elseif buftype == 'terminal' then
      local _, mtch = string.match(file, "term:(.*):(%a+)")
      return mtch ~= nil and mtch or vim.fn.fnamemodify(vim.env.SHELL, ':t')
    elseif file == '' then
      return '[No Name]'
    elseif vim.fn.fnamemodify(file, ':p:t') == 'mod.rs' then
      return (vim.fn.fnamemodify(file, ':h:t') .. '.rs')
    else
      return vim.fn.pathshorten(vim.fn.fnamemodify(file, ':p:~:t'))
    end
  end
}
require("luatab").setup(opts)
