{ config, pkgs, ... }:
let

  base = "#191724";
  surface = "#1f1d2e";
  overlay = "#26233a";
  muted = "#6e6a86";
  subtle = "#908caa";
  text = "#e0def4";
  love = "#eb6f92";
  gold = "#f6c177";
  rose = "#ebbcba";
  pine = "#31748f";
  foam = "#9ccfd8";
  iris = "#c4a7e7";
  highlightlow = "#21202e";
  highlightmed = "#403d52";
  highlighthigh = "#524f67";
in
{
  programs = {
    i3status = {
      enable = true;
      general = {
        colors = true;
        color_good = text;
        color_bad = love;
        color_degraded = gold;
      };
      modules = {
        ipv6.enable = false;
        "wireless _first_" = {
          position = 1;
          settings = {
            format_up = " %essid%quality [%bitrate]";
            format_down = "  down";
          };
        };
        "battery all".enable = false;
        "ethernet _first_".enable = false;
        "disk /".enable = false;
        "load".enable = false;
        memory.enable = false;
        "tztime local" = {
          settings = {
            format = "%Y-%m-%d %H:%M";
          };
          enable = true;
        };
      };
    };

  };

  xsession.windowManager.i3 =
    let
      i3_mod = "Mod1";
      mod_2 = "Mod4";
    in
    {
      enable = true;
      config = {
        bars = [{
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = [
              "Inter Variable"
            ];
            style = "Medium";
            size = 9.0;
          };
          colors = {
            background = base;
            statusline = text;
            separator = base;
            focusedWorkspace = {
              border = subtle;
              background = subtle;
              text = base;
            };
            inactiveWorkspace = {
              border = subtle;
              background = base;
              text = text;
            };
            urgentWorkspace = {
              border = love;
              background = base;
              text = text;
            };
            bindingMode = {
              border = gold;
              background = base;
              text = text;
            };
          };
        }];
        window = {
          titlebar = false;
          border = 2;
        };
        fonts = {
          names = [
            "Inter Variable"
          ];
          style = "Medium";
          size = 9.0;
        };
        colors = {
          background = base;
          placeholder = {
            background = base;
            text = text;
            indicator = overlay;
            border = base;
            childBorder = base;
          };
          urgent = {
            background = base;
            text = text;
            indicator = love;
            border = love;
            childBorder = love;
          };
          unfocused = {
            background = base;
            text = text;
            indicator = overlay;
            border = base;
            childBorder = base;
          };
          focusedInactive = {
            background = base;
            text = text;
            indicator = subtle;
            border = surface;
            childBorder = surface;
          };
          focused = {
            background = overlay;
            text = text;
            indicator = subtle;
            border = overlay;
            childBorder = overlay;
          };
        };
        modifier = i3_mod;

        floating = {
          modifier = i3_mod;
        };

        keybindings = {
          "${i3_mod}+Return" = "exec ${pkgs.wezterm}/bin/wezterm";
          "${mod_2}+space" = ''exec --no-startup-id "rofi -show drun -modi drun,calc,filebrowser"'';
          "${mod_2}+Shift+space" = "exec --no-startup-id ${pkgs.rofi}/bin/rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'";

          "${i3_mod}+space" = ''exec "setxkbmap -query | grep -q 'lt' && setxkbmap us || setxkbmap lt,us"'';

          "${i3_mod}+o" = "exec obsidian";

          "${i3_mod}+Shift+h" = "focus left";
          "${i3_mod}+Shift+j" = "focus down";
          "${i3_mod}+Shift+k" = "focus up";
          "${i3_mod}+Shift+l" = "focus right";

          "${i3_mod}+Control+h" = "move left";
          "${i3_mod}+Control+j" = "move down";
          "${i3_mod}+Control+k" = "move up";
          "${i3_mod}+Control+l" = "move right";

          "${i3_mod}+s" = "layout stacking";
          "${i3_mod}+t" = "layout tabbed";
          "${i3_mod}+w" = "layout toggle split";

          "${i3_mod}+Shift+space" = "floating toggle";
          "${i3_mod}+Shift+Return" = "focus mode_toggle";
          "${mod_2}+Control+space" = "exec --no-startup-id /etc/profiles/per-user/laurynask/bin/rofi -modi emoji -show emoji";

          "${i3_mod}+Shift+minus" = "move scratchpad";
          "${i3_mod}+minus" = "scratchpad show";

          "${i3_mod}+1" = "workspace number 1";
          "${i3_mod}+2" = "workspace number 2";
          "${i3_mod}+3" = "workspace number 3";
          "${i3_mod}+4" = "workspace number 4";
          "${i3_mod}+5" = "workspace number 5";
          "${i3_mod}+6" = "workspace number 6";
          "${i3_mod}+7" = "workspace number 7";
          "${i3_mod}+8" = "workspace number 8";
          "${i3_mod}+9" = "workspace number 9";

          "${i3_mod}+Shift+1" = "move container to workspace number 1";
          "${i3_mod}+Shift+2" = "move container to workspace number 2";
          "${i3_mod}+Shift+3" = "move container to workspace number 3";
          "${i3_mod}+Shift+4" = "move container to workspace number 4";
          "${i3_mod}+Shift+5" = "move container to workspace number 5";
          "${i3_mod}+Shift+6" = "move container to workspace number 6";
          "${i3_mod}+Shift+7" = "move container to workspace number 7";
          "${i3_mod}+Shift+8" = "move container to workspace number 8";
          "${i3_mod}+Shift+9" = "move container to workspace number 9";

          "${i3_mod}+Shift+c" = "reload";
          "${i3_mod}+Shift+r" = "restart";
          "${i3_mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
          "${mod_2}+${i3_mod}+Control+l" = "exec i3lock --image ~/Pictures/mountains.png";

          "${i3_mod}+r" = "mode resize";
          "${i3_mod}+q" = "kill";
        };
      };
    };
}
