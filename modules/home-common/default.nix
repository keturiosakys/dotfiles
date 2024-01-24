{ pkgs, ... }: {

  imports = [
    ../bat
    ../espanso
    ../fzf
    ../git
    ../hammerspoon
    ../karabiner
    ../neovim
    ../packages
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
      home-manager.enable = true;
      bash = { enable = true; };
      fish = { enable = true; };
      ripgrep = { enable = true; };
      starship = { enable = true; enableBashIntegration = false; };
      zoxide = { enable = true; };
      go = { enable = true; };
      direnv = { enable = true; nix-direnv.enable = true; };
    };

}
