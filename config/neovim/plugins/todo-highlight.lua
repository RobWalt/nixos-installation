require("todo-comments").setup({
  keywords = {
    FIX = {
      icon = " ",                                -- icon used for the sign, and in search results
      color = "error",                              -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },   -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "info" },
    HACK = { icon = " ", color = "warning", alt = { "TODO CRITICAL" } },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
  },
  merge_keywords = true,   -- when true, custom keywords will be merged with the defaults
  -- highlighting of the line containing the todo comment
  -- * before: highlights before the keyword (typically comment characters)
  -- * keyword: highlights of the keyword
  -- * after: highlights after the keyword (todo text)
  highlight = {
    before = "",                -- "fg" or "bg" or empty
    keyword = "bg",             -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "fg",               -- "fg" or "bg" or empty
    pattern = [[(KEYWORDS)]],   -- pattern or table of patterns, used for highlightng (vim regex)
    comments_only = true,       -- uses treesitter to match keywords in comments only
    max_line_len = 400,         -- ignore lines longer than this
    exclude = {},               -- list of file types to exclude highlighting
  },
  -- list of named colors where we try to extract the guifg from the
  -- list of hilight groups or use the hex color if hl not found as a fallback
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#e67e80" },
    warning = { "DiagnosticWarning", "WarningMsg", "#dbbc7f" },
    info = { "DiagnosticInfo", "#7fbbb3" },
    hint = { "DiagnosticHint", "#83c092" },
    default = { "Identifier", "#d699b6" },
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[//[ \t]*\b(KEYWORDS)\b]],   -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
})
