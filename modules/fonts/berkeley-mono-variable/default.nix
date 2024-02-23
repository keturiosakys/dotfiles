{ self, pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "berkeley-mono-variable";
  version = "1.010";
  src = self;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/berkeley-mono-variable
    cp -r berkeley-mono-variable/TTF/* $out/share/fonts/truetype/berkeley-mono-variable
  '';
}
