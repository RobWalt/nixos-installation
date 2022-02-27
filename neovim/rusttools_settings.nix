{}:
{
  content =
    ''
      lua << EOF
        local opts = {
          tools = {
            autoSetHints = true,
            hover_with_actions = true,
            runnables = {
              use_telescope = true
            },
            debuggables = {
              use_telescope = true
            },
            inlay_hints = {
              only_current_line = false,
              only_current_line_autocmd = "CursorHold",
              show_parameter_hints = true,
              parameter_hints_prefix = "<- ",
              other_hints_prefix = "=> ",
              max_len_align = false,
              max_len_align_padding = 1,
              right_align = false,
              right_align_padding = 7,
              highligh = "Comment",
            },
            hover_actions = {
              border = {
                {"x", "FloatBoarder"}, {"x", "FloatBoarder"},
                {"x", "FloatBoarder"}, {"x", "FloatBoarder"},
                {"x", "FloatBoarder"}, {"x", "FloatBoarder"},
                {"x", "FloatBoarder"}, {"x", "FloatBoarder"}
              },
              auto_focus = false
            },
            crate_graph = {
              backend = "x11",
              output = nil,
              full = true,
            }
          },
          server = {
          },
        }
        require('rust-tools').setup(opts)
      EOF

      "other Rust functionality
      au! CursorHold * call AutoDiagnosis()
      set updatetime=500
      func AutoDiagnosis()
        lua vim.diagnostic.open_float(nil, { focusable = false })
      endfunc
    '';
}
