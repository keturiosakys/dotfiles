{ ... }: {
  home.file = {
    # TODO: add check if darwin
    hammerspoon = {
      source = /Users/laurynas-fp/Code/keturiosakys/dotfiles/modules/hammerspoon;
      recursive = true;
      target = "/Users/laurynas-fp/.hammerspoon";
      onChange = "open -g hammerspoon://reload_configuration";
    };
  };
}
