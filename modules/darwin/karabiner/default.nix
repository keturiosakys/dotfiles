{ username, ... }: {

  homebrew.casks = [
    "karabiner-elements"
  ];

  home-manager.users.${username}.home.file = {
    karabiner = {
      source = ./karabiner.json;
    };
  };
}
