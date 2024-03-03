{ pkgs ? import <nixpkgs> { }, installShellFiles, ... }:
let
  name = "fp";
  version = "2.21.0";
  # aarch64-linux = "https://fp.dev/fp/v${version}/aarch64-unknown-linux-gnu/fp";
  # x86_64-apple-darwin = "https://fp.dev/fp/v${version}/x86_64-apple-darwin/fp";
  x86_64-linux = "https://fp.dev/fp/v${version}/x86_64-unknown-linux-gnu/fp";
  aarch64-apple-darwin = "https://fp.dev/fp/v${version}/aarch64-apple-darwin/fp";
  url = if pkgs.stdenv.isDarwin then aarch64-apple-darwin else x86_64-linux;
in
pkgs.stdenv.mkDerivation {
  inherit name version;
  src = pkgs.fetchurl {
    inherit url;
    sha256 = "sha256-Af8pur5BthryJTB8vRZgbkGLgCqpC2mpeYEiTPwItZo=";
  };

  phases = "installPhase postInstall";

  nativeBuildInputs = [ installShellFiles ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/fp
    chmod +x $out/bin/fp
  '';

  postInstall = ''
    installShellCompletion --cmd fp \
      --bash <($out/bin/fp completions bash) \
      --fish <($out/bin/fp completions fish) \
      --zsh  <($out/bin/fp completions zsh )
  '';

  meta = {
    description = "A general purpose cli tool for all things related to Fiberplane";
    homepage = "https://github.com/fiberplane/fp";
  };
}


