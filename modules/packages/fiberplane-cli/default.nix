{ pkgs, fetchFromGitHub, rustPlatform, installShellFiles, ... }:
let
  name = "fp";
  version = "2.22.0-beta.1";
in
rustPlatform.buildRustPackage rec {
  pname = name;
  inherit version;
  src = fetchFromGitHub {
    owner = "fiberplane";
    repo = name;
    rev = "v${version}";
    hash = "sha256-CM6NIWKFupBsbZzu1C/cmorzBtBO60v9PmVWwqWiQ7s=";
  };

  # cargoLock = {
  #   lockFile = ./Cargo.lock;
  # };

  cargoLock = {
    lockFileContents = builtins.readFile ./Cargo.lock;
  };

  nativeBuildInputs = [ installShellFiles ];

  postPatch = ''
    rm Cargo.lock
    ln -s ${./Cargo.lock} Cargo.lock
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


