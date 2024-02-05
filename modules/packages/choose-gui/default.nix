{ pkgs, stdenv, lib, fetchFromGitHub, darwin, ... }:
let
  frameworks = darwin.apple_sdk.frameworks;
  name = "choose";
  version = "1.3.1";
in

stdenv.mkDerivation {
  pname = name;
  inherit version;

  src = fetchFromGitHub {
    owner = "chipsenkbeil";
    repo = "choose";
    rev = "1.3.1";
    hash = "sha256-oR0GgMinKcBHaZWdE7O+mdbiLKKjkweECKbi80bjW+c=";
  };

  nativeBuildInputs = [
    pkgs.xcbuild
    frameworks.Cocoa
  ];

  preConfigure = "LD=$CC";

  #TODO: make this system agnostic
  buildPhase = ''
    xcodebuild -arch arm64 SDKROOT= SYMROOT=build -configuration Release build
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp build/Release/choose $out/bin
    chmod +x $out/bin/choose
  '';

  meta = with lib; {
    description = "Fuzzy matcher for OS X that uses both std{in,out} and a native GUI";
    homepage = "https://github.com/chipsenkbeil/choose";
    platforms = platforms.darwin;
    license = licenses.mit;
  };
}
