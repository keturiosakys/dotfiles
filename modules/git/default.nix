{ ... }: {
  programs = {
    git = {
      enable = true;
      userName = "Laurynas Keturakis";
      userEmail = "laurynas.keturakis@gmail.com";
      difftastic = {
        enable = true;
      };
      extraConfig = {
        pull.ff = "only";
        init.defaultBranch = "main";
      };

      aliases = {
        l = "log --pretty=format:'%C(yellow)%h%Creset %Cgreen%ad%Creset | %s%Creset %C(bold blue)[%an]%Creset' --date=short --graph";
        s = "status";
        c = "commit";
        cm = "commit -m";
        co = "checkout";
        sup = "submodule update --init --recursive";
      };

    };

    gh = {
      enable = true;

      gitCredentialHelper = {
        enable = true;
        hosts = [ "https://github.com" ];
      };

      settings = {
        git_protocol = "https";
        prompt = "enabled";
      };
    };
  };
}
