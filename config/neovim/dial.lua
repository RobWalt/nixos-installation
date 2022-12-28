lua << EOF
  local augend = require("dial.augend")
  require("dial.config").augends:register_group{
    -- default augends used when no group name is specified
    default = {
      augend.integer.alias.decimal_int,
      augend.integer.alias.hex,
      augend.date.alias["%d.%m.%Y"],
      augend.constant.alias.de_weekday,
      augend.constant.alias.de_weekday_full,
      augend.constant.alias.bool,
      augend.constant.alias.alpha,
      augend.constant.alias.Alpha,
      augend.semver.alias.semver,
    },
  }
EOF
