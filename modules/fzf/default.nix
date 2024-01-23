{...}: {
  programs = {
    fzf = {
      enable = true;
      changeDirWidgetOptions = [
        "--prompt 'cd> '"
        "--preview 'tree -C {}'"
      ];
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--bind 'ctrl-/:change-preview-window(50%|hidden|)'"
      ];

      fileWidgetOptions = [
        "--prompt 'Files> '"
        "--preview 'bat --color=always {}'"
        "--bind 'ctrl-/:change-preview-window(50%|hidden|)'"
      ];
      historyWidgetOptions = [
        "--prompt 'History> '"
        "--exact"
      ];
      colors = {
        "fg" = "#908caa,bg:#191724,hl:#ebbcba";
        "fg+" = "#e0def4,bg+:#26233a,hl+:#ebbcba";
        "border" = "#403d52,header:#31748f,gutter:#191724";
        "spinner" = "#f6c177,info:#9ccfd8,separator:#403d52";
        "pointer" = "#c4a7e7,marker:#eb6f92,prompt:#908caa";
      };
    };
  };
}
