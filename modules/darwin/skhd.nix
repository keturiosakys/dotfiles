{ config, pkgs, ... }:
let
  homeDir = config.users.users.laurynas-fp.home;
in
{
  launchd.user.agents.skhd.serviceConfig =
    {
      StandardErrorPath = "${homeDir}/Library/Logs/skhd.stderr.log";
      StandardOutPath = "${homeDir}/Library/Logs/skhd.stdout.log";
    };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      :: default
      :: manager

      alt - x ; manager
      manager < alt - x ; default
      
      # focus window
      manager < h : yabai -m window --focus west; skhd -k "alt - x"
      manager < j : yabai -m window --focus south; skhd -k "alt - x"
      manager < k : yabai -m window --focus north; skhd -k "alt - x"
      manager < l : yabai -m window --focus east; skhd -k "alt - x"

      # swap managed window
      manager < shift - h : yabai -m window --swap west; skhd -k "alt - x"
      manager < shift - j : yabai -m window --swap south; skhd -k "alt - x"
      manager < shift - k : yabai -m window --swap north; skhd -k "alt - x"
      manager < shift - l : yabai -m window --swap east; skhd -k "alt - x"

      # move managed window
      manager < ctrl - h : yabai -m window --warp west; skhd -k "alt - x"
      manager < ctrl - j : yabai -m window --warp south; skhd -k "alt - x"
      manager < ctrl - k : yabai -m window --warp north; skhd -k "alt - x"
      manager < ctrl - l : yabai -m window --warp east; skhd -k "alt - x"

      # rotate window
      manager < r : yabai -m space --rotate 270; skhd -k "alt - x"

      # toggle window fullscreen zoom
      manager < return : yabai -m window --toggle zoom-fullscreen; skhd -k "alt - x"

      # toggle padding and gap
      manager < g : yabai -m space --toggle padding; yabai -m space --toggle gap; skhd -k "alt - x"

      # float / unfloat window and center on screen
      manager < t : yabai -m window --toggle float; yabai -m window --grid 4:4:1:1:2:2; skhd -k "alt - x"

      # toggle window split type
      manager < space : yabai -m space --layout bsp; yabai -m space --balance; skhd -k "alt - x"
      manager < shift - space : yabai -m space --layout stack; skhd -k "alt - x"

      # stacking
      manager < p : yabai -m window --focus stack.next || yabai -m window --focus south; skhd -k "alt-x"
      manager < n : yabai -m window --focus stack.prev || yabai -m window --focus north; skhd -k "alt-x"
      manager < shift + ctrl - h  : yabai -m window west --stack $(yabai -m query --windows --window | jq -r '.id'); skhd -k "alt - x"
      manager < shift + ctrl - j  : yabai -m window south --stack $(yabai -m query --windows --window | jq -r '.id'); skhd -k "alt - x"
      manager < shift + ctrl - k    : yabai -m window north --stack $(yabai -m query --windows --window | jq -r '.id'); skhd -k "alt - x"
      manager < shift + ctrl - l    : yabai -m window east --stack $(yabai -m query --windows --window | jq -r '.id'); skhd -k "alt - x"

      # send window to monitor and follow focus
      cmd + ctrl + alt - right : yabai -m window --display next; yabai -m display --focus next
      cmd + ctrl + alt - left : yabai -m window --display prev; yabai -m display --focus prev

      manager < 1 : yabai -m window --space 1; yabai -m space --focus 1; skhd -k "alt - x"
      manager < 2 : yabai -m window --space 2; yabai -m space --focus 2; skhd -k "alt - x"
      manager < 3 : yabai -m window --space 3; yabai -m space --focus 3; skhd -k "alt - x"
      manager < 4 : yabai -m window --space 4; yabai -m space --focus 4; skhd -k "alt - x"

      # balance size of windows
      manager < 0 : yabai -m space --balance; skhd -k "alt - x"

      manager < down : yabai -m window --resize top:0:50; yabai -m window --resize bottom:0:50; skhd -k "alt - x"
      manager < up : yabai -m window --resize bottom:0:-50; yabai -m window --resize top:0:-50; skhd -k "alt - x"
      manager < left : yabai -m window --resize left:-100:0; yabai -m window --resize right:-100:0; skhd -k "alt - x"
      manager < right : yabai -m window --resize right:100:0; yabai -m window --resize left:100:0; skhd -k "alt - x"
    '';
  };

}
