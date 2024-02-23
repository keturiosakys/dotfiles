{ username }:
{ pkgs, ... }:
let
  keyd_file = "/home/laurynask/.config/keyd/app.conf";
in
{

  home-manager.users.${username} = {

    home = {
      packages = [
        pkgs.keyd
      ];

      file.${keyd_file}.text = ''
        [firefox]

        meta = alt
      '';
    };

  };


  services = {
    keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control,esc)";
            };
          };
        };
      };
    };
  };
}
