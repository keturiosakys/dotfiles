{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    darwin = { url = "github:LnL7/nix-darwin"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { nixpkgs, home-manager, darwin, ... }:
    let
      macOS = "aarch64-darwin";
      usernameWork = "laurynas-fp";

      getPkgsForSystem = system: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; allowUnfreePredicate = _: true; };
      };

      Frodo-Baggins = import ./hosts/Frodo-Baggins { username = usernameWork; };
      home-common = import ./modules/home-common;
      home-work = import ./modules/home-work { username = usernameWork; };

    in
    {

      # darwinConfigurations = {
      #   Frodo-Baggins = darwin.lib.darwinSystem {
      #     system = macOS;
      #     pkgs = getPkgsForSystem macOS;
      #     modules = [
      #       Frodo-Baggins
      #       home-manager.darwinModules.home-manager
      #       {
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.users."${usernameWork}" = { ... }: {
      #           imports = [ home-common home-work ];
      #         };
      #       }
      #     ];
      #   };
      # };

      homeConfigurations = {
        "${usernameWork}" = home-manager.lib.homeManagerConfiguration {
          pkgs = getPkgsForSystem macOS;
          modules = [
            home-common
            home-work
          ];
        };
      };
    };
}
