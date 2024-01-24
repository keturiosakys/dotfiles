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
      "espanso"
      "font-hack"
      "font-inter"
      "google-chrome"
      "google-drive"
      "hammerspoon"
      "iina"
      "karabiner-elements"
      "keyboardcleantool"
      "mixxx"
      "middle"
      "obsidian"
      "orbstack"
      "skim"
      "slack"
      "sloth"
      "visual-studio-code"
      "wezterm-nightly"
      "zed"
    ];
  };
}
