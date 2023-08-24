{ adminName, ... }:
''
  #!/bin/bash

  tmux new-session -d -s work -n db -c /home/${adminName}/repos/bauhaus
  tmux new-window -n code -c /home/${adminName}/repos/bauhaus/services/rust/
  tmux new-window -n execute -c /home/${adminName}/repos/bauhaus/services/rust/
  tmux new-window -n shell -c /home/${adminName}/repos/bauhaus/services/rust/
  tmux new-window -n web-app -c /home/${adminName}/repos/bauhaus/web/web-app/
''
