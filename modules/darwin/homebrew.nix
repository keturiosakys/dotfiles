{ ... }: {
  homebrew = {
    enable = true;

    onActivation = {
      upgrade = true;
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
      "arc"
      "balenaetcher"
      "cleanshot"
      "contexts"
      "discord"
      "dozer"
      "espanso"
      "font-hack"
      "font-inter"
      "google-chrome"
      "google-drive"
      "iina"
      "iterm2"
      "keyboardcleantool"
      "markedit"
      "mixxx"
      "middle"
      "obsidian"
      "orbstack"
      "raycast"
      "rio"
      "skim"
      "slack"
      "sloth"
      "stats"
      "visual-studio-code"
      "wezterm-nightly"
      "zed"
    ];
  };
}
