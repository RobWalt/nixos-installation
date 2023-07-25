{ ... }:
let
  names = import ../../../names.nix { };
in
''
  #!/bin/bash

  sh /home/${names.userName}/.tmux/init-tmux-system.sh
  sh /home/${names.userName}/.tmux/init-tmux-work.sh
  sh /home/${names.userName}/.tmux/init-tmux-freetime.sh
''
