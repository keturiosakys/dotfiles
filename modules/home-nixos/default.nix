{ pkgs, lib, ... }:
{
  imports = [
    ../autorandr
    ../i3
    ../gtk
    ../rofi
    ../solaar
  ];

  home.packages = with pkgs; [
    _1password-gui
    discord
    google-chrome
    newsflash
    obsidian
    slack
    signal-desktop
    sublime4

    dnsutils
    file
    gnutar
    iputils
    unzip
    zip

    guvcview

    glibc

    libnotify
    inotify-tools
    lm_sensors
    lsof
    ltrace
    pciutils
    strace
    usbutils
  ];

  programs = {
    vscode.enable = true;
    firefox.enable = true;
    fish = {
      functions = {
        pbcopy = ''
          xclip -sel clip
        '';
        pbpaste = ''
          xclip -sel clip -o
        '';
      };
    };
  };

  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          startupLaunch = true;
          contrastOpacity = 188;
          copyOnDoubleClick = true;
          savePath = "/home/laurynask/Pictures/screenshots";
        };
      };
    };

    dunst = {
      enable = true;
      iconTheme.name = "Adwaita";
      iconTheme.package = pkgs.gnome.adwaita-icon-theme;
      settings = {
        urgency_low = {
          background = "#1e1e1e";
          foreground = "#ffffff";
        };
        urgency_normal = {
          background = "#242424";
          foreground = "#ffffff";
        };
        urgency_critical = {
          background = "#ff7b63";
          foreground = "#ffffff";
        };
      };
    };

    darkman =
      {
        enable = true;
        settings = {
          lat = 52.4;
          lng = 4.9;
          usegeoclue = true;
        };
        darkModeScripts.color-scheme-dark = ''
          dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        '';

        lightModeScripts.color-scheme-light = ''
          dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
        '';
      };

  };


  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-key-theme-name=Emacs
  '';


}
