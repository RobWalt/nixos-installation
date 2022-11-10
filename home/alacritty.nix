{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      color_schemes = {
        latte = {
          # Default colors
          primary = {
            background = "#EFF1F5"; # base
            foreground = "#4C4F69"; # text
            # Bright and dim foreground colors
            dim_foreground = "#4C4F69"; # text
            bright_foreground = "#4C4F69"; # text
          };

          # Cursor colors
          cursor = {

            text = "#EFF1F5"; # base
            cursor = "#DC8A78"; # rosewater
          };

          vi_mode_cursor = {
            text = "#EFF1F5"; # base
            cursor = "#7287FD"; # lavender
          };

          # Search colors
          search = {
            matches = {
              foreground = "#EFF1F5"; # base
              background = "#6C6F85"; # subtext0
            };
            focused_match = {
              foreground = "#EFF1F5"; # base
              background = "#40A02B"; # green
            };
            footer_bar = {

              foreground = "#EFF1F5"; # base
              background = "#6C6F85"; # subtext0
            };
          };

          # Keyboard regex hints
          hints = {
            start = {
              foreground = "#EFF1F5"; # base
              background = "#DF8E1D"; # yellow
            };
            end = {
              foreground = "#EFF1F5"; # base
              background = "#6C6F85"; # subtext0
            };
          };

          # Selection colors
          selection = {
            text = "#EFF1F5"; # base
            background = "#DC8A78"; # rosewater
          };

          # Normal colors
          normal = {
            black = "#5C5F77"; # subtext1
            red = "#D20F39"; # red
            green = "#40A02B"; # green
            yellow = "#DF8E1D"; # yellow
            blue = "#1E66F5"; # blue
            magenta = "#EA76CB"; # pink
            cyan = "#179299"; # teal
            white = "#ACB0BE"; # surface2
          };

          # Bright colors
          bright = {
            black = "#6C6F85"; # subtext0
            red = "#D20F39"; # red
            green = "#40A02B"; # green
            yellow = "#DF8E1D"; # yellow
            blue = "#1E66F5"; # blue
            magenta = "#EA76CB"; # pink
            cyan = "#179299"; # teal
            white = "#BCC0CC"; # surface1
          };

          # Dim colors
          dim = {
            black = "#5C5F77"; # subtext1
            red = "#D20F39"; # red
            green = "#40A02B"; # green
            yellow = "#DF8E1D"; # yellow
            blue = "#1E66F5"; # blue
            magenta = "#EA76CB"; # pink
            cyan = "#179299"; # teal
            white = "#ACB0BE"; # surface2
          };

          indexed_colors = [
            {
              index = 16;
              color = "#FE640B";
            }
            {
              index = 17;
              color = "#DC8A78";
            }
          ];
        };
        frappe = {

          # Default colors
          primary = {
            background = "#303446"; # base
            foreground = "#C6D0F5"; # text
            # Bright and dim foreground colors
            dim_foreground = "#C6D0F5"; # text
            bright_foreground = "#C6D0F5"; # text
          };

          # Cursor colors
          cursor = {
            text = "#303446"; # base
            cursor = "#F2D5CF"; # rosewater
          };
          vi_mode_cursor = {
            text = "#303446"; # base
            cursor = "#BABBF1"; # lavender
          };

          # Search colors
          search = {
            matches = {
              foreground = "#303446"; # base
              background = "#A5ADCE"; # subtext0
            };
            focused_match = {
              foreground = "#303446"; # base
              background = "#A6D189"; # green
            };
            footer_bar = {
              foreground = "#303446"; # base
              background = "#A5ADCE"; # subtext0
            };
          };

          # Keyboard regex hints
          hints = {
            start = {
              foreground = "#303446"; # base
              background = "#E5C890"; # yellow
            };
            end = {
              foreground = "#303446"; # base
              background = "#A5ADCE"; # subtext0
            };
          };

          # Selection colors
          selection = {
            text = "#303446"; # base
            background = "#F2D5CF"; # rosewater
          };

          # Normal colors
          normal = {
            black = "#51576D"; # surface1
            red = "#E78284"; # red
            green = "#A6D189"; # green
            yellow = "#E5C890"; # yellow
            blue = "#8CAAEE"; # blue
            magenta = "#F4B8E4"; # pink
            cyan = "#81C8BE"; # teal
            white = "#B5BFE2"; # subtext1
          };

          # Bright colors
          bright = {
            black = "#626880"; # surface2
            red = "#E78284"; # red
            green = "#A6D189"; # green
            yellow = "#E5C890"; # yellow
            blue = "#8CAAEE"; # blue
            magenta = "#F4B8E4"; # pink
            cyan = "#81C8BE"; # teal
            white = "#A5ADCE"; # subtext0
          };

          # Dim colors
          dim = {
            black = "#51576D"; # surface1
            red = "#E78284"; # red
            green = "#A6D189"; # green
            yellow = "#E5C890"; # yellow
            blue = "#8CAAEE"; # blue
            magenta = "#F4B8E4"; # pink
            cyan = "#81C8BE"; # teal
            white = "#B5BFE2"; # subtext1
          };

          indexed_colors = [
            {
              index = 16;
              color = "#EF9F76";
            }
            {
              index = 17;
              color = "#F2D5CF";
            }
          ];
        };


        macchiato = {
          # Default colors
          primary = {
            background = "#24273A"; # base
            foreground = "#CAD3F5"; # text
            # Bright and dim foreground colors
            dim_foreground = "#CAD3F5"; # text
            bright_foreground = "#CAD3F5"; # text
          };

          # Cursor colors
          cursor = {
            text = "#24273A"; # base
            cursor = "#F4DBD6"; # rosewater
          };
          vi_mode_cursor = {
            text = "#24273A"; # base
            cursor = "#B7BDF8"; # lavender
          };

          # Search colors
          search = {
            matches = {
              foreground = "#24273A"; # base
              background = "#A5ADCB"; # subtext0
            };
            focused_match = {
              foreground = "#24273A"; # base
              background = "#A6DA95"; # green
            };
            footer_bar = {
              foreground = "#24273A"; # base
              background = "#A5ADCB"; # subtext0
            };
          };

          # Keyboard regex hints
          hints = {
            start = {
              foreground = "#24273A"; # base
              background = "#EED49F"; # yellow
            };
            end = {
              foreground = "#24273A"; # base
              background = "#A5ADCB"; # subtext0
            };
          };

          # Selection colors
          selection = {
            text = "#24273A"; # base
            background = "#F4DBD6"; # rosewater
          };
          # Normal colors
          normal = {
            black = "#494D64"; # surface1
            red = "#ED8796"; # red
            green = "#A6DA95"; # green
            yellow = "#EED49F"; # yellow
            blue = "#8AADF4"; # blue
            magenta = "#F5BDE6"; # pink
            cyan = "#8BD5CA"; # teal
            white = "#B8C0E0"; # subtext1
          };
          # Bright colors
          bright = {
            black = "#5B6078"; # surface2
            red = "#ED8796"; # red
            green = "#A6DA95"; # green
            yellow = "#EED49F"; # yellow
            blue = "#8AADF4"; # blue
            magenta = "#F5BDE6"; # pink
            cyan = "#8BD5CA"; # teal
            white = "#A5ADCB"; # subtext0
          };
          # Dim colors
          dim = {
            black = "#494D64"; # surface1
            red = "#ED8796"; # red
            green = "#A6DA95"; # green
            yellow = "#EED49F"; # yellow
            blue = "#8AADF4"; # blue
            magenta = "#F5BDE6"; # pink
            cyan = "#8BD5CA"; # teal
            white = "#B8C0E0"; # subtext1
          };
          indexed_colors =
            [
              {
                index = 16;
                color = "#F5A97F";
              }
              {
                index = 17;
                color = "#F4DBD6";
              }
            ];
        };


        mocha = {

          # Default colors
          primary = {
            background = "#1E1E2E"; # base
            foreground = "#CDD6F4"; # text
            # Bright and dim foreground colors
            dim_foreground = "#CDD6F4"; # text
            bright_foreground = "#CDD6F4"; # text
          };
          # Cursor colors
          cursor = {
            text = "#1E1E2E"; # base
            cursor = "#F5E0DC"; # rosewater
          };
          vi_mode_cursor = {
            text = "#1E1E2E"; # base
            cursor = "#B4BEFE"; # lavender
          };
          # Search colors
          search = {
            matches = {
              foreground = "#1E1E2E"; # base
              background = "#A6ADC8"; # subtext0
            };
            focused_match = {
              foreground = "#1E1E2E"; # base
              background = "#A6E3A1"; # green
            };
            footer_bar = {
              foreground = "#1E1E2E"; # base
              background = "#A6ADC8"; # subtext0
            };

            # Keyboard regex hints
            hints = {
              start = {
                foreground = "#1E1E2E"; # base
                background = "#F9E2AF"; # yellow
              };
              end = {
                foreground = "#1E1E2E"; # base
                background = "#A6ADC8"; # subtext0
              };
            };

            # Selection colors
            selection = {
              text = "#1E1E2E"; # base
              background = "#F5E0DC"; # rosewater
            };

            # Normal colors
            normal = {
              black = "#45475A"; # surface1
              red = "#F38BA8"; # red
              green = "#A6E3A1"; # green
              yellow = "#F9E2AF"; # yellow
              blue = "#89B4FA"; # blue
              magenta = "#F5C2E7"; # pink
              cyan = "#94E2D5"; # teal
              white = "#BAC2DE"; # subtext1
            };

            # Bright colors
            bright = {
              black = "#585B70"; # surface2
              red = "#F38BA8"; # red
              green = "#A6E3A1"; # green
              yellow = "#F9E2AF"; # yellow
              blue = "#89B4FA"; # blue
              magenta = "#F5C2E7"; # pink
              cyan = "#94E2D5"; # teal
              white = "#A6ADC8"; # subtext0
            };

            # Dim colors
            dim = {
              black = "#45475A"; # surface1
              red = "#F38BA8"; # red
              green = "#A6E3A1"; # green
              yellow = "#F9E2AF"; # yellow
              blue = "#89B4FA"; # blue
              magenta = "#F5C2E7"; # pink
              cyan = "#94E2D5"; # teal
              white = "#BAC2DE"; # subtext1
            };

            indexed_colors =
              [
                { index = 16; color = "#FAB387"; }
                { index = 17; color = "#F5E0DC"; }
              ];
          };
        };
      };
      colors = {

        # Default colors
        primary = {
          background = "#1E1E2E"; # base
          foreground = "#CDD6F4"; # text
          # Bright and dim foreground colors
          dim_foreground = "#CDD6F4"; # text
          bright_foreground = "#CDD6F4"; # text
        };
        # Cursor colors
        cursor = {
          text = "#1E1E2E"; # base
          cursor = "#F5E0DC"; # rosewater
        };
        vi_mode_cursor = {
          text = "#1E1E2E"; # base
          cursor = "#B4BEFE"; # lavender
        };
        # Search colors
        search = {
          matches = {
            foreground = "#1E1E2E"; # base
            background = "#A6ADC8"; # subtext0
          };
          focused_match = {
            foreground = "#1E1E2E"; # base
            background = "#A6E3A1"; # green
          };
          footer_bar = {
            foreground = "#1E1E2E"; # base
            background = "#A6ADC8"; # subtext0
          };

          # Keyboard regex hints
          hints = {
            start = {
              foreground = "#1E1E2E"; # base
              background = "#F9E2AF"; # yellow
            };
            end = {
              foreground = "#1E1E2E"; # base
              background = "#A6ADC8"; # subtext0
            };
          };

          # Selection colors
          selection = {
            text = "#1E1E2E"; # base
            background = "#F5E0DC"; # rosewater
          };

          # Normal colors
          normal = {
            black = "#45475A"; # surface1
            red = "#F38BA8"; # red
            green = "#A6E3A1"; # green
            yellow = "#F9E2AF"; # yellow
            blue = "#89B4FA"; # blue
            magenta = "#F5C2E7"; # pink
            cyan = "#94E2D5"; # teal
            white = "#BAC2DE"; # subtext1
          };

          # Bright colors
          bright = {
            black = "#585B70"; # surface2
            red = "#F38BA8"; # red
            green = "#A6E3A1"; # green
            yellow = "#F9E2AF"; # yellow
            blue = "#89B4FA"; # blue
            magenta = "#F5C2E7"; # pink
            cyan = "#94E2D5"; # teal
            white = "#A6ADC8"; # subtext0
          };

          # Dim colors
          dim = {
            black = "#45475A"; # surface1
            red = "#F38BA8"; # red
            green = "#A6E3A1"; # green
            yellow = "#F9E2AF"; # yellow
            blue = "#89B4FA"; # blue
            magenta = "#F5C2E7"; # pink
            cyan = "#94E2D5"; # teal
            white = "#BAC2DE"; # subtext1
          };

          indexed_colors =
            [
              { index = 16; color = "#FAB387"; }
              { index = 17; color = "#F5E0DC"; }
            ];
        };
      };
      #window = {
      #  opacity = 0.9;
      #};
      font = {
        normal = {
          family = "Iosevka Nerd Font Mono";
          style = "Regular";
        };
      };
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
        #args = [
        #  "-l"
        #  "-c"
        #  "tmux attach || tmux"
        #];
      };
    };
  };
}
