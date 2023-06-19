local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- LEADER
vim.g.mapleader = ','

map("n", "<space>", "<Nop>")

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    function ListWorkspaces()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end

    function FormatManually()
      vim.lsp.buf.format { async = true }
    end

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    map("n", "gd", "<cmd>Telescope lsp_definitions theme=ivy initial_mode=normal<CR>")
    map('n', 'K', vim.lsp.buf.hover, opts)
    map("n", "gi", "<cmd>Telescope lsp_implementations theme=ivy initial_mode=normal<CR>")
    map("n", "gr", "<cmd>Telescope lsp_references theme=ivy initial_mode=normal<CR>")
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', ListWorkspaces, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    map({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>f', FormatManually, opts)
  end,
})

-- NORMAL

map("n", "gp", "<cmd>Telescope yank_history<CR>")
map("n", "p", "<cmd> lua require('yanky').put('p')<CR>")
map("n", "P", "<cmd> lua require('yanky').put('P')<CR>")

map('n', '<space>e', "<cmd>lua vim.diagnostic.open_float()<CR>")
map('n', '<space>q', "<cmd>lua vim.diagnostic.setloclist()<CR>")

map("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<C-a>", require('dial.map').inc_normal())
map("n", "<C-C>", "<cmd>Telescope git_commits initial_mode=normal<CR>")
map("n", "<C-e>", "<cmd>Telescope find_files<CR>")
map("n", "<C-f>", ":NvimTreeFindFileToggle<CR>")
map("n", "<C-g>", "<cmd>Telescope live_grep<CR>")
map("n", "<C-j>", "<cmd>Telescope diagnostics initial_mode=normal<CR>")
map("n", "<C-q>", "<cmd>Telescope current_buffer_fuzzy_find<CR>")
map("n", "<C-s>", "<cmd>Telescope git_status initial_mode=normal<CR>")
map("n", "<C-x>", require('dial.map').dec_normal())

map("n", "<A-,>", ":tabprevious<CR>")
map("n", "<A-.>", ":tabnext<CR>")
map("n", "<A-h>", ":tabmove -1<CR>")
map("n", "<A-l>", ":tabmove +1<CR>")
map("n", "<A-z>", "<cmd>ZenMode<CR>")
map("n", "<A-o>", "<cmd>RustOpenExternalDocs<CR>")
map("n", "<A-c>", "<cmd>!echo hi<CR>")
map("n", "<A-k>", "<cmd>!echo hi<CR>")

map("n", "<Leader>t", "<cmd>TodoTelescope<CR>")
map("n", "<Leader>le", "<space><ESC>hi<cmd>lua require('telescope.builtin').symbols({sources = {'emoji'}})<CR>")
map("n", "<Leader>lm", "<space><ESC>hi<cmd>lua require('telescope.builtin').symbols({sources = {'math'}})<CR>")

-- VISUAL
map("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>")

-- INSERT
