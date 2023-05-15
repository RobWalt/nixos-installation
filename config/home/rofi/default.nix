{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-emoji
    ];
    package = pkgs.rofi;
    theme = builtins.toString (pkgs.writeText "rofi-theme" ''
      * {
          al:                             #00000000;
          bg:                             #45475A;
          se:                             #A6ADC8;
          fg:                             #45475A;
          ac:                             #FAB387;
      }

      configuration {
      	  font:							              "Iosevka Nerd Font 10";
          show-icons:                     true;
      	  icon-theme: 					          "Papirus";
          display-drun: 					        "Apps";
          drun-display-format:            "{name}";
          disable-history:                false;
          fullscreen:                     false;
      	  hide-scrollbar: 				        true;
      	  sidebar-mode: 					        false;
      }

      window {
          transparency:                   "screenshot";
          background-color:               @bg;
          text-color:                     @fg;
      	  border:							            0px;
      	  border-color:					          @ac;
          border-radius:                  15px;
      	  width:							            35%;
          location:                       center;
          x-offset:                       0;
          y-offset:                       0;
      }

      prompt {
          enabled: 						            true;
      	  padding: 						            1% 0.75% 1% 0.75%;
      	  background-color: 	            @ac;
      	  text-color: 				            @fg;
          border-radius:                  10px;
      	  font:							              "Iosevka Nerd Font 12";
      }

      textbox-prompt-colon {
      	  padding: 						            1% 0% 1% 0%;
      	  background-color: 	            @se;
      	  text-color: 				            @fg;
      	  expand:                         false;
      	  str:                            " :: ";
      }

      entry {
          background-color:               @al;
          text-color:                     @fg;
          placeholder-color:              @fg;
          expand:                         true;
          horizontal-align:               0;
          placeholder:                    "Search...";
      	  padding: 						            1.15% 0.5% 1% 0.5%;
          blink:                          true;
      }

      inputbar {
      	  children: 						          [ prompt, entry ];
          background-color:               @se;
          text-color:                     @fg;
          expand:                         false;
      	  border:							            0% 0% 0% 0%;
          border-radius:                  10px;
      	  border-color:					          @ac;
      }

      listview {
          background-color:               @al;
          padding:                        0px;
          columns:                        2;
          lines:                          7;
          spacing:                       	1%;
          cycle:                          false;
          dynamic:                        true;
          layout:                         vertical;
      }

      mainbox {
          background-color:               @al;
      	  border:							            0% 0% 0% 0%;
          border-radius:                  0% 0% 0% 0%;
      	  border-color:					          @ac;
          children:                       [ inputbar, listview ];
          spacing:                       	2%;
          padding:                        4% 2% 4% 2%;
      }

      element {
          background-color:               @se;
          text-color:                     @fg;
          orientation:                    horizontal;
          border-radius:                  12px;
          padding:                        1% 0.5% 1% 0.75%;
      }

      element-icon {
          background-color:               @al;
          size:                           24px;
          border:                         0px;
      }

      element-text {
          background-color:               @al;
          expand:                         true;
          horizontal-align:               0;
          vertical-align:                 0.5;
          margin:                         0% 0.25% 0% 0.25%;
      }

      element selected {
          background-color:               @ac;
          text-color:                     @se;
      }
    '');
  };
}
