lua << EOF
  require('telescope').setup({
    defaults = {
      layout_config = {
        horizontal = {
          height = 0.9,
          preview_cutoff = 120,
          preview_width = 120,
          prompt_position = "bottom",
          width = 0.8
        },
      },
    },
  })
  require('telescope').load_extension("yank_history")
EOF
