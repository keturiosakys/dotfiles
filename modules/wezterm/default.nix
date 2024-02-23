{ pkgs, ... }: {
  programs.wezterm.enable = !pkgs.stdenv.isDarwin;
  xdg.configFile.wezterm = {
    enable = true;
    recursive = true;
    source = ./.;
  };
}
