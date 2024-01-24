{ ... }:
let
  configPath = "/Users/laurynas-fp/Library/Application Support";
in
{

  home.file = {
    "${configPath}/espanso" = {
      source = ./esp;
      recursive = true;
    };
  };

  # services.espanso = {
  #   enable = false; #TODO: add a gate  if Linux
  #   config = {
  #     toggle_key = "RIGHT_ALT";
  #     search_shortcut = "off";
  #   };
  #   matches = {
  #     base = {
  #       matches = [
  #         {
  #           trigger = "ddate";
  #           replace = "{{date}}";
  #         }
  #       ];
  #     };
  #     global_vars = {
  #       global_vars = [
  #         {
  #           name = "date";
  #           type = "date";
  #           params = { format = "%e %b %Y"; };
  #         }
  #       ];
  #     };
  #   };
  # };
}
