{ ... }:
let
  names = import ../../../names.nix { };
in
'' 
#!/bin/bash

tmux new-session -d -s freetime -n general -c /home/${names.userName}/ 
tmux new-window -n happycode -c /home/${names.userName}/ 
''
