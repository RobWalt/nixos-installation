{ inputs, ... }:
let inherit (inputs) adminName; in
''
  set $mod Mod4

  font pango:Droid Sans 12
  # Use Mouse+$mod to drag floating windows to their wanted position
  floating_modifier $mod

  # start a terminal
  bindsym $mod+Return exec alacritty

  # kill focused window
  bindsym $mod+Shift+q kill

  # start dmenu (a program launcher)
  bindsym $mod+d exec "rofi -dpi 170 -modi drun -show drun"

  # type emoji
  bindsym $mod+b exec "rofi -modi emoji -show emoji -run-command '{cmd}'; sleep 0.1; xdotool type $(xclip -o -sel clip)"

  # type clipboard
  bindsym $mod+n exec "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'; sleep 0.1; xdotool type $(xclip -o -sel clip)"

  bindsym $mod+p exec "ROFI_PASS_CONFIG='/home/${adminName}/.config/rofi-pass/config' rofi-pass"

  # There also is the (new) i3-dmenu-desktop which only displays applications
  # shipping a .desktop file. It is a wrapper around dmenu, so you need that
  # installed.
  # bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

  # feh
  exec_always --no-startup-id "feh /home/${adminName}/wallpaper/bg/ -z --bg-max --image-bg \"#345\""

  # greenclip
  exec_always --no-startup-id "killall -q greenclip || greenclip daemon"

  # change focus
  bindsym $mod+j focus left
  bindsym $mod+k focus down
  bindsym $mod+l focus up
  bindsym $mod+semicolon focus right

  # alternatively, you can use the cursor keys:
  bindsym $mod+Left focus left
  bindsym $mod+Down focus down
  bindsym $mod+Up focus up
  bindsym $mod+Right focus right

  # lock windows
  bindsym $mod+Shift+l exec "i3lock-fancy -g"

  # screenshot
  bindsym Print exec --no-startup-id "flameshot gui"

  # alternatively, you can use the cursor keys:
  bindsym $mod+Shift+Left move left
  bindsym $mod+Shift+Down move down
  bindsym $mod+Shift+Up move up
  bindsym $mod+Shift+Right move right

  # split in horizontal orientation
  bindsym $mod+h split h

  # split in vertical orientation
  bindsym $mod+v split v

  # change container layout (stacked, tabbed, toggle split)
  bindsym $mod+s layout stacking
  bindsym $mod+w layout tabbed
  bindsym $mod+e layout toggle split

  # toggle tiling / floating
  bindsym $mod+space floating toggle

  # change focus between tiling / floating windows
  bindsym $mod+Shift+space focus mode_toggle

  # focus the parent container
  bindsym $mod+a focus parent

  # focus the child container
  #bindsym $mod+d focus child switch to workspace
  bindsym $mod+1 workspace 1
  bindsym $mod+2 workspace 2
  bindsym $mod+3 workspace 3
  bindsym $mod+4 workspace 4
  bindsym $mod+5 workspace 5
  bindsym $mod+6 workspace 6
  bindsym $mod+7 workspace 7
  bindsym $mod+8 workspace 8
  bindsym $mod+9 workspace 9
  bindsym $mod+0 workspace 10

  # move focused container to workspace
  bindsym $mod+Shift+1 move container to workspace 1
  bindsym $mod+Shift+2 move container to workspace 2
  bindsym $mod+Shift+3 move container to workspace 3
  bindsym $mod+Shift+4 move container to workspace 4
  bindsym $mod+Shift+5 move container to workspace 5
  bindsym $mod+Shift+6 move container to workspace 6
  bindsym $mod+Shift+7 move container to workspace 7
  bindsym $mod+Shift+8 move container to workspace 8
  bindsym $mod+Shift+9 move container to workspace 9
  bindsym $mod+Shift+0 move container to workspace 10

  # reload the configuration file
  bindsym $mod+Shift+c reload
  # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
  bindsym $mod+Shift+r restart

  bindsym XF86MonBrightnessUp exec brightnessctl s +10%  # increase screen brightness
  bindsym XF86MonBrightnessDown exec brightnessctl s 10%-  # decrease screen brightness
  # Pulse Audio controls
  # increase sound volume
  bindsym XF86AudioRaiseVolume exec --no-startup-id "amixer sset Master 10%+"
  # decrease sound volume
  bindsym XF86AudioLowerVolume exec --no-startup-id "amixer sset Master 10%-"
  # mute sound
  bindsym XF86AudioMute exec --no-startup-id "amixer sset Master toggle"

  mode "adjust" {
    bindsym h move left
    bindsym k move up
    bindsym j move down
    bindsym l move right

    bindsym Shift+l resize grow width 5 px or 5 ppt
    bindsym Shift+h resize shrink width 5 px or 5 ppt
    bindsym Shift+j resize grow height 5 px or 5 ppt
    bindsym Shift+k resize shrink height 5 px or 5 ppt

    bindsym semicolon resize grow width 5 px or 5 ppt

    bindsym Return mode "default"
    bindsym Escape mode "default"
  }

  bindsym $mod+m mode "adjust"
  bindsym $mod+f fullscreen

  # class                 border  bground text    indicator child_border
  client.focused          #d3c6aa #d3c6aa #4b565c #d3c6aa   #d3c6aa
  client.focused_inactive #4b565c #4b565c #FFFFFF #4b565c   #4b565c
  client.unfocused        #2b3339 #2b3339 #d3c6aa #2b3339   #2b3339
  client.urgent           #e67e80 #e67e80 #FFFFFF #e67e80   #e67e80
  client.placeholder      #2b3339 #2b3339 #d3c6aa #2b3339   #2b3339

  client.background       #FFFFFF

  for_window [class=".*"] border pixel 2

  bar {
  	position top
  	mode hide
  	hidden_state hide
  	modifier $mod

  	colors {
  		background #1E1E2E
  		statusline #F9E2AF
  		separator #F9E2AF

  		focused_workspace #1E1E2E #89B4FA #1E1E2E
  		active_workspace #1E1E2E #1E1E2E #F9E2AF
  		inactive_workspace #1E1E2E #1E1E2E #F9E2AF
  		urgent_workspace #1E1E2E #F38BA8 #1E1E2E
  		binding_mode #1E1E2E #F38BA8 #1E1E2E
  	}
  }

  hide_edge_borders smart

  gaps inner 0 
''
