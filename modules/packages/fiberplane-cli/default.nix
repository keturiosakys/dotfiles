{ fetchFromGitHub, rustPlatform, darwin, installShellFiles, ... }:
let
  frameworks = darwin.apple_sdk.frameworks;
  name = "fp";
  version = "2.18.0";
in

rustPlatform.buildRustPackage {
  pname = name;
  inherit version;

  buildInputs = [
    frameworks.IOKit
    frameworks.CoreFoundation
    frameworks.CoreServices
    frameworks.Security
    frameworks.SystemConfiguration
  ];

  nativeBuildInputs = [ installShellFiles ];

  src = fetchFromGitHub {
    owner = "fiberplane";
    repo = name;
    rev = "20e8a66efd4ed3b695af640533ec44d30f781fa1";
    hash = "sha256-gGYaaudTWs5qTYYrvzhexQFSFWNxzUpTBcGaLP+S+Zw=";
  };

  cargoHash = "sha256-ParS9Klex4s6oDTJ3FCxR+8oZ9Qo5zecKZqMfmdP48Q=";

  cargoLock = {
    lockFile = ./Cargo.lock;
    allowBuiltinFetchGit = true;
  };

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
