{ inputs, pkgs, ... }:
let
  fiberplane-cli = pkgs.callPackage ./fiberplane-cli { };
  choose = pkgs.callPackage ./choose-gui { };
  dotfiles = pkgs.writeShellScriptBin "dotfiles" (builtins.readFile ./scripts/dotfiles.sh);
in
{
  home = {
    packages = [
      fiberplane-cli
      choose
      dotfiles

    ] ++ (with pkgs; [

      # Unix tools
      bashInteractive
      bat
      bat
      coreutils
      curl
      curlie
      entr
      erdtree
      eza
      fd
      ffmpeg
      fzf
      gawkInteractive
      git
      gnugrep
      gnused
      (pkgs.writeShellScriptBin "gsed" "exec ${pkgs.gnused}/bin/sed \"$@\"")
      hyperfine
      inetutils
      jless
      jq
      just
      ngrok
      nix-zsh-completions
      nixpkgs-fmt
      nixpacks
      nurl
      ripgrep
      sd
      xq-xml
      zoxide
      zsh
      zsh-completions
      zsh-fzf-tab

      # Compilers and runtimes
      deno
      elixir_1_16
      inputs.lexical-lsp.packages.${system}.lexical
      erlang
      emscripten
      go
      livebook
      nodePackages.pnpm
      nodejs_20
      protobuf_25
      python312
      templ

      # rust
      cargo
      perl
      rustc
      sccache

      # Container and cloud tools
      _1password
      act
      awscli2
      docker
      docker-compose
      github-cli
      k9s
      kubectl
      kubernetes-helm
      podman
      prometheus # monitoring
      cf-terraforming # terraform for cloudflare
      terraform # terraform
      tilt # dev tool for k8s
      delta # diff tool
      difftastic # diff tool
      htop-vim # htop with vim bindings
      iftop # network monitor
      lazygit # git UI
      lazydocker # docker UI
      visidata # spreadsheet for the terminal

      railway # railway.app
      flyctl # fly.io
      tldr # docs for CLI commands

      pandoc # document converter
      # texliveFull
      grc # colorize output of various commands
    ]);
  };
}
