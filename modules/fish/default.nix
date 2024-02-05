{ pkgs, ... }:
let
  rose-pine = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "fish";
    rev = "main";
    hash = "sha256-bSGGksL/jBNqVV0cHZ8eJ03/8j3HfD9HXpDa8G/Cmi8=";
  };
in
{
  xdg.configFile."fish/themes/Rosé Pine.theme".source = "${rose-pine}/themes/Rosé Pine.theme";

  programs = {
    fish = {
      enable = true;
      shellAliases = import ../shellAliases.nix;
      shellAbbrs = import ../shellAbbreviations.nix;

      interactiveShellInit = ''
        ${builtins.readFile ./wezterm-integration.fish}
        source $HOME/Code/keturiosakys/dotfiles/modules/fish/iterm2_integration.fish
        ${builtins.readFile ./config.fish}
      '';

      functions = {
        kubens = ''
          kubectl config set-context \
            --current \
            --namespace=$(kubectl get namespace --no-headers | fzf | awk '{ print $1}')
        '';
        tailf = "tail -f $1 | fzf +s";
        jqf = ''
          : | fzf \
          --print-query \
          --layout=reverse \
          --preview "cat $1 | jq {q}"
        '';
        notify = "printf ']777;notify;%s;%s\\' '$1' '$2'";
      };

      plugins = [ ] ++ [
        { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
        { name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src; }
        { name = "fzf"; src = pkgs.fishPlugins.fzf-fish.src; }
        #TODO: only for macOS
        {
          name = "osx";
          src = pkgs.fetchFromGitHub
            {
              owner = "oh-my-fish";
              repo = "plugin-osx";
              rev = "master";
              sha256 = "sha256-jSUIk3ewM6QnfoAtp16l96N1TlX6vR0d99dvEH53Xgw=";
            };
        }

      ];

    };
  };
}
