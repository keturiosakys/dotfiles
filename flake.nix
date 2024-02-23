{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    darwin = { url = "github:LnL7/nix-darwin"; inputs.nixpkgs.follows = "nixpkgs"; };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    lexical-lsp.url = "github:lexical-lsp/lexical";
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs:
    let
      macOS = "aarch64-darwin";
      linux = "x86_64-linux";
      username = "laurynask";
      usernameWork = "laurynas-fp";

      Frodo-Baggins = import ./modules/darwin { username = usernameWork; };
      Gimli = import ./modules/nixos/configuration.nix { inherit username; };

      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];

      getPkgsForSystem = system: import nixpkgs {
        inherit system overlays;
        config = { allowUnfree = true; allowUnfreePredicate = _: true; };
      };
    in
    {

      nixosConfigurations = {
        Gimli = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            Gimli
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.${username}.imports = [ ./modules/home-common ./modules/home-nixos ];
              };
            }
          ];
        };
      };

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
                useUserPackages = false;
                extraSpecialArgs = { inherit inputs; };
                users."${usernameWork}".imports = [ ./modules/home-common ];
              };
            }
          ];
        };
      };
    };
}
