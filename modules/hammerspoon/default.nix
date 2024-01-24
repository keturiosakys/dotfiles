{ ... }: {
  home.file = {
    # TODO: add check if darwin
    hammerspoon = {
      source = ./hsp;
      recursive = true;
      target = ".hammerspoon";
    };
  };
}
