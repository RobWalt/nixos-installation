{ ... }:
let
  names = import ../../../names.nix { };
in
''
  #!/bin/bash

  tmux new-session -d -s work -n db -c /home/${names.userName}/repos/bauhaus
  tmux new-window -n code -c /home/${names.userName}/repos/bauhaus/services/rust/
  tmux new-window -n execute -c /home/${names.userName}/repos/bauhaus/services/rust/
  tmux new-window -n shell -c /home/${names.userName}/repos/bauhaus/services/rust/
  tmux new-window -n web-app -c /home/${names.userName}/repos/bauhaus/web/web-app/
''
