{ ... }: {
  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "zap";
    };

    taps = [
      "homebrew/cask-fonts"
    ];

    casks = [
      # "1password"
      "1password-cli"
      "alfred"
      "appcleaner"
      "arduino"
      "balenaetcher"
      "cleanshot"
      "discord"
      "dozer"
      "font-hack"
      "font-inter"
      "google-chrome"
      "google-drive"
      "hammerspoon"
      "iina"
      "karabiner-elements"
      "mixxx"
      "obsidian"
      "orbstack"
      "skim"
      "slack"
      "sloth"
      "sublime-text"
      "visual-studio-code"
      "wezterm-nightly"
    ];
  };
}
