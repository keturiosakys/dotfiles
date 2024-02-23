{ pkgs, ... }: {

  imports = [
    ../bat
    ../espanso
    ../fish
    ../fzf
    ../git
    ../neovim
    ../packages
    ../starship
    ../yamlfmt
    ../wezterm
    ../zsh
  ];

  home = {
    stateVersion = "23.11";
    sessionPath = [
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
      "$HOME/.go/bin"
      "/opt/homebrew/bin/"
    ];

    sessionVariables = {
      EDITOR = "nvim";
      DIRENV_LOG_FORMAT = "";
      GOBIN = "$HOME/.go/bin";
      GOPATH = "$HOME/.go";
      FZF_COMPLETION_TRIGGER = "~~";
      ZSH_AUTOSUGGEST_USE_ASYNC = "true";
    };

    shellAliases = import ../shellAliases.nix;
  };

  programs =
    {
      home-manager = { enable = true; };

      atuin = {
        enable = true;
        flags = [ "--disable-up-arrow" ];
      };

      bash = { enable = true; };
      direnv = { enable = true; nix-direnv.enable = true; };
      go = { enable = true; };
      ripgrep = { enable = true; };
      zoxide = { enable = true; };
    };

}
