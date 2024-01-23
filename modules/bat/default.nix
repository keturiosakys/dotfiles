{ pkgs, ... }: {
  programs = {

    bat = {
      enable = true;
      config =
        {
          theme = "rose-pine";
        };
      themes = {
        rose-pine = {
          src = pkgs.fetchFromGitHub {
            owner = "rose-pine";
            repo = "sublime-text";
            rev = "main";
            hash = "sha256-zQ/H7W6ToRy6J0vVtHDqV6rbyUdG1EpGb07HsV+2R24=";
          };
          file = "rose-pine.tmTheme";
        };
      };
    };
  };
}
