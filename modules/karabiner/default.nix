{ ... }: {
  home.file = {
    karabiner = {
      source = "~/Code/keturiosakys/dotfiles/modules/karabiner/karabiner.json";
      target = "~/.config/karabiner/karabiner.json";
    };
  };
}
