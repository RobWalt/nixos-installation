lua << EOF
  local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  vim.g.mapleader = ','
  map("n", "<C-f>", ":NvimTreeFindFileToggle<CR>", {silent = true})
  map("n", "<C-K>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {silent = true})
  map("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<CR>", {silent = true})
  map("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", {silent = true})
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {silent = true})
  map("n", "gD", "<cmd>Telescope diagnostics theme=ivy initial_mode=normal<CR>", {silent = true})
  map("n", "gd", "<cmd>Telescope lsp_definitions theme=ivy initial_mode=normal<CR>", {silent = true})
  map("n", "gi", "<cmd>Telescope lsp_implementations theme=ivy initial_mode=normal<CR>", {silent = true})
  map("n", "gr", "<cmd>Telescope lsp_references theme=ivy initial_mode=normal<CR>", {silent = true})
  map("n", "gp", "<cmd>Telescope yank_history<CR>", {silent = true})
  map("n", "ga", "<cmd>lua vim.lsp.buf.code_action() initial_mode=normal<CR>", {silent = true})
  map("n", "<C-a>", require('dial.map').inc_normal(), {noremap = true})
  map("n", "<C-x>", require('dial.map').dec_normal(), {noremap = true})
  map("n", "p", "<cmd> lua require('yanky').put('p')<CR>", {silent = true, noremap = true})
  map("n", "P", "<cmd> lua require('yanky').put('P')<CR>", {silent = true, noremap = true})
  map("n", "<C-e>", "<cmd>Telescope find_files<CR>", {silent = true})
  map("n", "<C-q>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", {silent = true})
  map("n", "<C-g>", "<cmd>Telescope live_grep<CR>", {silent = true})
  map("n", "<C-s>", "<cmd>Telescope git_status initial_mode=normal<CR>", {silent = true})
  map("n", "<C-c>", "<cmd>Telescope git_commits initial_mode=normal<CR>", {silent = true})
  map("n", "<C-j>", "<cmd>Telescope diagnostics initial_mode=normal<CR>", {silent = true})
  map("n", "<Leader>m", "<cmd>lua vim.lsp.buf.rename()<CR>", {silent = true})
  map("n", "<A-,>", ":tabprevious<CR>", {silent = true})
  map("n", "<A-.>", ":tabnext<CR>", {silent = true})
  map("n", "<A-h>", ":tabmove -1<CR>", {silent = true})
  map("n", "<A-l>", ":tabmove +1<CR>", {silent = true})
  map("n", "<A-z>", "<cmd>ZenMode<CR>", {silent = true})
  map("n", "<Leader>t", "<cmd>TodoTelescope<CR>", {silent = true})

  map("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>")

  map("i", "<A-m>", "<space><ESC>hi<cmd>lua require('telescope.builtin').symbols({sources = {'math'}})<CR>", {silent = true})
  map("i", "<A-e>", "<space><ESC>hi<cmd>lua require('telescope.builtin').symbols({sources = {'emoji'}})<CR>", {silent = true})
EOF
