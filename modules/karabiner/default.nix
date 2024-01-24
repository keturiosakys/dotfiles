{ ... }: {
  home.file = {
    # TODO: add check if darwin
    karabiner = {
      source = /Users/laurynas-fp/Code/keturiosakys/dotfiles/modules/karabiner/karabiner.json;
      target = "/Users/laurynas-fp/.config/karabiner/karabiner.json";
    };
  };
}
