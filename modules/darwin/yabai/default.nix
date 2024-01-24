{ config, ... }: {
  services.yabai = {
    enable = true;
    config = {
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      window_origin_display = "default";
      window_placement = "second_child";
      window_topmost = "off";
      window_shadow = "float";
      window_opacity = "off";
      window_opacity_duration = 0.0;
      active_window_opacity = 1.0;
      normal_window_opacity = 0.7;
      window_border = "off";
      window_border_width = "3";
      split_ratio = 0.50;
      auto_balance = "off";
      mouse_modifier = "fn";
      mouse_action1 = "swap";
      mouse_action2 = "resize";
      mouse_drop_action = "move";
      layout = "bsp";
    };

    extraConfig = builtins.readFile ./yabairc;
  };

  launchd.user.agents.yabai.serviceConfig =
    let
      homeDir = config.users.users.laurynas-fp.home;
    in
    {
      StandardErrorPath = "${homeDir}/Library/Logs/yabai.stderr.log";
      StandardOutPath = "${homeDir}/Library/Logs/yabai.stdout.log";
    };

}
