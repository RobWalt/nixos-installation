{ adminName, ... }:
''
  #!/bin/bash

  sh /home/${adminName}/.tmux/init-tmux-system.sh
  sh /home/${adminName}/.tmux/init-tmux-work.sh
  sh /home/${adminName}/.tmux/init-tmux-freetime.sh
''
