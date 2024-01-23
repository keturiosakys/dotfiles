{ pkgs, ... }:
let
  fiberplane-cli = pkgs.callPackage ./fiberplane-cli { };
in
{
  home = {
    packages = [
      fiberplane-cli
    ] ++ (with pkgs; [

      # Unix tools
      bashInteractive
      coreutils
      inetutils
      gnused
      gawkInteractive
      gnugrep
      nixpkgs-fmt
      curl
      curlie
      nurl
      git
      jq
      jless
      bat
      eza
      erdtree
      hyperfine
      entr
      fzf
      ngrok
      zsh-fzf-tab
      zsh-completions
      nix-zsh-completions
      zsh
      fd
      sd
      ffmpeg
      ripgrep
      bat
      zoxide
      just

      #neovim

      # Compilers and runtimes
      deno
      nodejs_20
      nodePackages.pnpm
      elixir_1_16
      emscripten
      erlang
      livebook
      go
      templ
      python312

      # rust
      cargo
      perl 
      rustc

      # Container and cloud tools
      act
      awscli2
      colima
      docker
      docker-compose
      podman
      github-cli
      prometheus
      terraform
      tilt
      k9s
      kubectl
      kubernetes-helm

      delta
      difftastic
      htop-vim
      iftop
      lazygit
      lazydocker
      espanso
      visidata

      railway
      flyctl
      tldr

      pandoc
    ]);
  };
}
