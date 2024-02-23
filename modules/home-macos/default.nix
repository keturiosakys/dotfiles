{ pkgs, ... }:
let
  choose = pkgs.callPackage ./choose-gui { };
in
{

  home = {
    packages = [
      choose
      pkgs.inetutils
    ];
  };

}
