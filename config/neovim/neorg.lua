lua << EOF
  require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.integrations.telescope"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.journal"] = {},
        ["core.norg.completion"] = {
          config = {
            engine = "nvim-cmp",
          }
        },
        ["core.norg.dirman"] = {
            config = {
              workspaces = {
                work = "~/notes/work",
                school = "~/notes/school",
                private = "~/notes/private",
                journal = "~/notes/journal",
                oss = "~/notes/opensource"
              }
            }
          },
    }
}
EOF
