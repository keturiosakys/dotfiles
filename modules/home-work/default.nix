{ username }: { ... }: {
  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
  };
}
