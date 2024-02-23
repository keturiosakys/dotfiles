{ username }:
{ pkgs, ... }: {

  services.picom = {
    enable = true;
    settings = {
      picom.enable = true;
      unredir-if-possible = false;
    };
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us,lt";
    };

    libinput = {
      mouse = {
        accelProfile = "adaptive";
        accelSpeed = "1";
        naturalScrolling = true;
      };
    };

    autoRepeatDelay = 220;
    autoRepeatInterval = 15;

    displayManager = {
      lightdm = {
        enable = true;
        background = "/home/laurynask/.background-image";
        greeters.mini = {
          enable = true;
          user = username;
          extraConfig = ''
            [greeter]
            show-password-label = false
            [greeter-theme]
            layout-space = 25
            font = "Inter"
            font-size = 18
            window-color = "#000000"
            border-width = 0
            background-image = "/etc/lightdm/.background-image"
          '';
        };
      };
      defaultSession = "none+i3";
      sessionCommands = ''
        keyd-application-mapper -d
      '';
    };

    desktopManager = {
      xterm.enable = false;
      wallpaper.mode = "fill";
      # xfce = {
      #   enable = true;
      #   noDesktop = true;
      #   enableXfwm = false;
      # };
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ i3status i3lock i3lock-fancy i3blocks i3-balance-workspace ];
      extraSessionCommands = ''
        feh --bg-scale /home/laurynask/.background-image
      '';
    };
  };
}
