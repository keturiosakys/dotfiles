{ lib, ... }: {
  programs = {
    starship = {
      enable = true;
      enableBashIntegration = false;
      settings = {
        format = lib.strings.concatStrings [
          "$time"
          "$nix_shell"
          "$os"
          "$directory"
          "$container"
          "$aws"
          "$git_branch$git_status"
          "$line_break"
          "$cmd_duration"
          "$status"
          "$character"
        ];
        add_newline = false;
        line_break = { disabled = false; };
        character = {
          success_symbol = "[;](bold green)";
        };
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
        git_branch = {
          symbol = " ";
        };
        nix_shell = {
          disabled = false;
          format = "[$symbol$name]($style) ";
          symbol = "※ ";
        };
        cmd_duration = {
          disabled = false;
          min_time = 5000;
          # show_notifications = true;
          # min_time_to_notify = 10000;
        };
        time = {
          disabled = false;
          format = "[\\[$time\\]](dimmed) ";
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
