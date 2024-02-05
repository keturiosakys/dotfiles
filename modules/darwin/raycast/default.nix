{ username, ... }: {

  homebrew.casks = [
    "raycast"
  ];

  system = {
    defaults = {
      CustomUserPreferences = {
        "com.raycast.macos" = {
          raycastGlobalHotkey = "Command-49";
        };
      };
    };
  };

}
