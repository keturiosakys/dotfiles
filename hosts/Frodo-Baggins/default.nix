{ username }: { pkgs, ... }:
{

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

  programs = {
    zsh.enable = true;
    fish.enable = true;
    bash.enable = true;
    nix-index.enable = true;
  };

  system = {
    stateVersion = 4;
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };

  # networking = {
  #   hostName = hostname;
  #   computerName = hostname;
  #   knownNetworkService = [
  #     "Wi-Fi"
  #     "USB 10/100/1000 LAN"
  #     "Thunderbolt Bridge"
  #   ];
  # };

  users.users."${username}" = {
    name = username;
    home = "/Users/${username}";
    description = username;
    shell = pkgs.zsh;
  };
}
