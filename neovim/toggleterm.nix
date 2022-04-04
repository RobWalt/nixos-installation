{}:
''
  lua << EOF
  require("toggleterm").setup {
    open_mapping = [[<c-t>]],
    hide_numbers = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "double",
      width = math.floor(vim.o.columns * 0.75),
      height = math.floor(vim.o.lines * 0.75),
    },
  }
  EOF
''
