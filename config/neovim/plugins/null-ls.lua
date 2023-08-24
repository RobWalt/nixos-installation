local null_ls = require("null-ls")

-- TODO use ltrs in the future when available on nix

local cspell_sources_actions = null_ls.builtins.code_actions.cspell
local cspell_sources_diagnostics = null_ls.builtins.diagnostics.cspell
local spell_sources = null_ls.builtins.completion.spell
spell_sources["filetypes"] = { "text", "markdown" }
cspell_sources_diagnostics["filetypes"] = { "text", "markdown" }

local statix_sources_diagnostics = null_ls.builtins.diagnostics.statix
local statix_sources_actions = null_ls.builtins.code_actions.statix

null_ls.setup({
  sources = {
    -- code actions
    cspell_sources_actions,
    --gitsigns_sources,
    statix_sources_actions,
    -- completions
    spell_sources,
    cspell_sources_diagnostics,
    statix_sources_diagnostics,
  },
})
