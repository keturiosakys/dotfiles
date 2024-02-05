{ lib, ... }: {
  programs = {
    starship = {
      enable = true;
      enableBashIntegration = false;
      settings = {
        add_newline = false;
        line_break = { disabled = true; };
        character = {
          success_symbol = "[;](bold green)";
        };
        format = lib.strings.concatStrings [
          "$nix_shell"
          "$os"
          "$directory"
          "$container"
          "$aws"
          "$git_branch$git_status"
          "$cmd_duration"
          "$status"
          "$character"
        ];
        # git_branch = {
        #   symbol = " ";
        # };
        directory = {
          truncation_length = 100;
          truncate_to_repo = false;
          format = "[$path]($style)[$read_only]($read_only_style) ";
          read_only = " □ ";
        };
        hostname = {
          ssh_only = true;
          format = "<[$hostname]($style)>";
          trim_at = "-";
          style = "bold dimmed white";
        };
        nix_shell = {
          disabled = false;
          format = "[$symbol$name]($style) ";
          # symbol = " ";
          symbol = "※ ";
        };
        status = {
          symbol = "×";
          not_found_symbol = "Not Found";
          not_executable_symbol = "Can't Execute";
          success_symbol = "";
          format = "[$symbol](fg:red)";
          recognize_signal_code = true;
          map_symbol = true;
          disabled = false;
        };
        memory_usage = {
          disabled = false;
          threshold = 75;
          symbol = "🐏";
          format = "[$symbol$ram]($style) ";
          style = "bold dimmed white";
        };
      };
    };
  };
}
