{ username }:
{ inputs
, lib
, config
, pkgs
, ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix

    ../fonts

    (import ../keyd { inherit username; })
    (import ../xserver { inherit username; })
  ];

  nixpkgs = {

    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
    ];

    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
        "openssl-1.1.1w"
      ];
    };

  };

  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc =
    lib.mapAttrs'
      (name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
      })
      config.nix.registry;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  networking = {
    hostName = "gimli-son-of-gloin";
    networkmanager = {
      enable = true;
      # insertNameservers = [ "1.1.1.1" "9.9.9.9" ];
      unmanaged = [ "interface-name:wlp3s0" ];
    };
    firewall = {
      enable = true;
      allowPing = true;
    };
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8814au ];

  environment.systemPackages = with pkgs; [
    feh
    steam-run-native
    vial
    xclip
    xorg.xev
  ];
  environment.variables.EDITOR = "nvim";
  time.timeZone = "Europe/Amsterdam";

  services = {
    blueman.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    greenclip.enable = true;
    udev.packages = [ pkgs.via ];
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };

  sound.enable = true;
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    keyboard.qmk.enable = true;
    logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
    opengl = {
      enable = true;
      driSupport = true;
    };
    pulseaudio = {
      enable = true;
    };
  };

  programs = {
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-archive-plugin
      ];
    };
    dconf.enable = true;
    fish.enable = true;
    _1password-gui.enable = true;
    _1password.enable = true;
  };

  users.users = {
    ${username} = {
      isNormalUser = true;
      description = "Laurynas Keturakis";
      extraGroups = [ "networkmanager" "wheel" "keyd" "docker" ];
      shell = pkgs.fish;
    };
  };

  system.stateVersion = "23.11";

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
