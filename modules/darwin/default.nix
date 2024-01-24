{ username }: { pkgs, ... }:
{
  imports = [
    ./homebrew.nix
    ./skhd.nix
    ./yabai
  ];

  programs.zsh.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ username ];
    };
  };

  nixpkgs.config.allowUnfree = true;

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
      NSGlobalDomain = {
        KeyRepeat = 1;
        InitialKeyRepeat = 13;
      };
    };
  };

  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
    packages = with pkgs; [ skhd ];
  };
}
