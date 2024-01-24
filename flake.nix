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

      Frodo-Baggins = import ./modules/darwin { username = usernameWork; };

      getPkgsForSystem = system: import nixpkgs {
        inherit system;
        config = { allowUnfree = true; allowUnfreePredicate = _: true; };
      };
    in
    {

      darwinConfigurations = {
        Frodo-Baggins = darwin.lib.darwinSystem {
          system = macOS;
          pkgs = getPkgsForSystem macOS;
          modules = [
            Frodo-Baggins
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."${usernameWork}".imports = [ ./modules/home-common ];
              };
            }
          ];
        };
      };

      # homeConfigurations = {
      #   "${usernameWork}" = home-manager.lib.homeManagerConfiguration {
      #     pkgs = getPkgsForSystem macOS;
      #     modules = [
      #       home-common
      #       {
      #         home = {
      #           username = usernameWork;
      #           homeDirectory = "/Users/${usernameWork}";
      #         };
      #       }
      #     ];
      #   };
      # };
    };
}
