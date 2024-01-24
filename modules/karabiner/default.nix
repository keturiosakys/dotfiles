{ ... }: {
  home.file = {
    # TODO: add check if darwin
    karabiner = {
      source = ./karabiner.json;
    };
  };
}
