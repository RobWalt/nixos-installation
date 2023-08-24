{ adminName, ... }:
'' 
#!/bin/bash

tmux new-session -d -s freetime -n general -c /home/${adminName}/ 
tmux new-window -n happycode -c /home/${adminName}/ 
''
