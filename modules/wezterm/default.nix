{ ... }: {
  xdg.configFile.wezterm = {
    enable = true;
    recursive = true;
    source = ./.;
  };
}
