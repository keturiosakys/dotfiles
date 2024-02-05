{ ... }: {
  xdg.configFile = {
    yamlfmt = {
      enable = true;
      text = ''
        formatter:
          type: basic
          scan_folded_as_literal: true
          retain_line_breaks: true
      '';
      target = "./yamlfmt/.yamlfmt";
    };
  };
}
