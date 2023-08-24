{ adminName, ... }:
''
  #!/usr/bin/env bash

  # Prevent unformatted pushes for rust work
  for FILE in `git diff --cached --name-only`; do
    if [[ -f $FILE ]] \
      && [[ $FILE == *.rs ]] \
      && [[ `pwd` =~ 'bauhaus' ]] \
      && ! rustfmt +nightly --edition 2021 --check --config-path /home/${adminName}/repos/bauhaus/services/rust/rustfmt.toml $FILE; then
      echo "Commit rejected due to invalid formatting of \"$FILE\" file."
      exit 1
    fi
  done
''
