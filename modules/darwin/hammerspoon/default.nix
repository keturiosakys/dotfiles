{ username, ... }: {

  homebrew.casks = [
    "hammerspoon"
  ];

  home-manager.users.${username}.home.file = {
    hammerspoon = {
      source = ./.;
      recursive = true;
      target = ".hammerspoon";
    };
  };
}
