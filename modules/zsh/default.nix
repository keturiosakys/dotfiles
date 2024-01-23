{ pkgs, ... }:
let
  fetchFromGitHub = pkgs.fetchFromGitHub;
in
{

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      autocd = true;
      dotDir = ".config/zsh";
      shellAliases = import ../shellAliases.nix; # TODO: this might need to be import ./modules/shellAliases.nix

      initExtra = ''
      '' + builtins.readFile ./config.zsh;

      initExtraFirst = ''
        bindkey -e
        zmodload zsh/zprof
      '';

      zsh-abbr = {
        enable = true;
        abbreviations = import ../shellAbbreviations.nix;
      };


      plugins = [
        {
          name = "zsh-autopair";
          src = fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "master";
            hash = "sha256-PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
          };
          file = "autopair.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.8.0";
            hash = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
          };
        }
        {
          name = "zsh-rose-pine";
          src = fetchFromGitHub {
            owner = "rose-pine";
            repo = "linux-tty";
            rev = "main";
            hash = "sha256-FtXw1uaA4RSwnRtdDdvEqQ79+KDC9gQahP2eDSPzwNU=";
          };

          file = "dist/rose-pine.sh";
        }
        {
          name = "fzf-tab";
          src = fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "c2b4aa5ad2532cca91f23908ac7f00efb7ff09c9";
            hash = "sha256-gvZp8P3quOtcy1Xtt1LAW1cfZ/zCtnAmnWqcwrKel6w=";
          };
        }
      ];

    };
  };
}
