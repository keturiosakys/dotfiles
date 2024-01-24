{ ... }: {
  home.file = {
    hammerspoon = {
      source = "~/Code/keturiosakys/dotfiles/modules/hammerspoon";
      recursive = true;
      target = ".hammerspoon";
      onChange = "open -g hammerspoon://reload_configuration";
    };
  };
}
