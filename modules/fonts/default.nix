{ pkgs, ... }:
let
  berkeley-mono-variable = pkgs.callPackage ./fonts/berkeley-mono-variable { };

in
{
  fonts =
    {
      enableDefaultPackages = true;
      packages = [
        berkeley-mono-variable
      ] ++ (with pkgs; [
        line-awesome
        inter
        inconsolata
        overpass
        powerline-fonts
        source-code-pro
        source-sans-pro
        source-serif-pro
      ]);
      fontconfig = {
        enable = true;
        antialias = true;
        cache32Bit = true;
        hinting.enable = true;
        hinting.autohint = true;
        defaultFonts = {
          monospace = [ "Berkeley Mono Variable" ];
          sansSerif = [ "Inter" ];
          serif = [ "Source Serif Pro" ];
        };
      };
    };

}
