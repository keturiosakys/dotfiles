{ username }:
{ pkgs, inputs, ... }:
let
  inherit username;
in
{
  imports = [
    ./homebrew.nix
    (import ./karabiner { inherit username; })
    (import ./hammerspoon { inherit username; })
    (import ./raycast { inherit username; })
    ./yabai
  ];

  programs.fish.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      trusted-users = [ username ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

  services.nix-daemon.enable = true;

  system = {
    stateVersion = 4;
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    keyboard = {
      enableKeyMapping = true;
    };

    defaults = {

      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = false;
      };

      NSGlobalDomain = {
        KeyRepeat = 1;
        InitialKeyRepeat = 13;
      };
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  environment.shells = with pkgs; [
    fish
    zsh
  ];

  environment.loginShell = pkgs.fish;

  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
    packages = with pkgs; [ skhd yabai ];
    shell = pkgs.fish;
  };
}
