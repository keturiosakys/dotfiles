{ pkgs, inputs, ... }: {

  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

  home = {
    packages = with pkgs; [
      biome
      clippy
      eslint_d
      gopls
      nixpkgs-fmt
      prettierd
      rust-analyzer
      stylua
      yamlfmt
    ];
  };

  programs.neovim =
    let
      fetchFromGitHub = pkgs.fetchFromGitHub;
      buildVimPlugin = pkgs.vimUtils.buildVimPlugin;
      # toLua = str: "lua << EOF\n${str}\nEOF\n";
      # toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";

      laurynas = buildVimPlugin {
        name = "laurynas";
        src = ./.;
      };

      undo-tree = buildVimPlugin {
        pname = "undotree";
        version = "2023-12-29";
        src = fetchFromGitHub {
          owner = "jiaoshijie";
          repo = "undotree";
          rev = "80552a0180b49e5ba072c89ae91ce5d4e3aed36b";
          sha256 = "sha256-clxoKM5kusRz8OR5+Z+4NS0WsoMx9tdyi9GG+sE6r3s=";
        };
      };

      rose-pine = buildVimPlugin {
        pname = "rose-pine";
        version = "2024-01-07";
        src = fetchFromGitHub {
          owner = "rose-pine";
          repo = "neovim";
          rev = "v2.0.0";
          sha256 = "sha256-ROa6x065EB7z9V8rAQJXlOmGZay06FvfDJfPKC2IrQA=";
        };
        meta.homepage = "https://github.com/rose-pine/neovim";
      };

      harpoon = buildVimPlugin {
        pname = "harpoon";
        version = "v2";
        src = fetchFromGitHub {
          owner = "ThePrimeagen";
          repo = "harpoon";
          rev = "harpoon2";
          sha256 = "sha256-MUIGRoaFcCqqFatfnFJpnEOUmSYJgV2+teU/NXj6kgY=";
        };
        meta.homepage = "https://github.com/ThePrimeagen/harpoon";
      };

      mini-move = buildVimPlugin rec {
        pname = "mini-move";
        version = "0.11.0";
        src = fetchFromGitHub {
          owner = "echasnovski";
          repo = "mini.move";
          rev = "v${version}";
          sha256 = "sha256-lgRM8D3TbQi0WYXYjcXq8uTen6qwVo/nKv6cEPoDPoA=";
        };
        meta.homepage = "https://github.com/echasnovski/mini.nvim";
      };

      mini-clue = buildVimPlugin rec {
        pname = "mini-clue";
        version = "0.11.0";
        src = fetchFromGitHub {
          owner = "echasnovski";
          repo = "mini.clue";
          rev = "v${version}";
          sha256 = "sha256-HV+ezAozENXFFNqfz8efuTvDZJWFym14/TBf1Z1AKsc=";
        };
        meta.homepage = "https://github.com/echasnovski/mini.nvim";
      };


    in
    {
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;
      package = pkgs.neovim-nightly;

      extraPackages = with pkgs; [
        nodePackages_latest."@astrojs/language-server"
        nodePackages_latest.bash-language-server
        emmet-language-server
        helm-ls
        dockerfile-language-server-nodejs
        docker-compose-language-service
        elixir-ls

        lua-language-server
        nil
        tailwindcss-language-server
        terraform-ls
        tflint
        nodePackages_latest.typescript-language-server
        vscode-langservers-extracted
        yaml-language-server
      ];

      plugins = (with pkgs.vimPlugins; [
        aerial-nvim
        comment-nvim

        dressing-nvim
        harpoon
        plenary-nvim
        popup-nvim
        SchemaStore-nvim
        tabular
        # nvim-web-devicons
        todo-comments-nvim
        indent-blankline-nvim
        gitsigns-nvim

        vim-helm
        fidget-nvim
        vim-slime

        mini-move
        mini-clue
        undo-tree

        #completions
        nvim-cmp
        cmp-buffer
        cmp-cmdline
        cmp-nvim-lsp
        cmp-nvim-lua
        cmp-path
        cmp-treesitter
        cmp_luasnip
        luasnip
        vim-fugitive
        vim-rhubarb

        #LSP
        lspkind-nvim
        conform-nvim
        rust-tools-nvim
        none-ls-nvim
        nvim-lspconfig


        copilot-cmp
        copilot-lua


        lsp-status-nvim
        lualine-nvim

        nui-nvim
        neo-tree-nvim
        rose-pine
        # smart-splits-nvim
        Navigator-nvim
        nvim-surround
        nvim-spectre

        telescope-zf-native-nvim
        telescope-nvim

        nvim-unception

        nvim-treesitter-context
        nvim-treesitter-textobjects
        nvim-ts-context-commentstring
        nvim-ts-autotag
        {
          plugin = (nvim-treesitter.withPlugins (plugins: with plugins; [
            astro
            bash
            c
            comment
            css
            dockerfile
            eex
            elixir
            fish
            git_config
            git_rebase
            go
            gomod
            gosum
            haskell
            hcl
            html
            java
            javascript
            json
            jsonnet
            latex
            lua
            make
            markdown
            markdown-inline
            mermaid
            nix
            ocaml
            ocaml_interface
            python
            promql
            regex
            requirements
            ruby
            rust
            scala
            scss
            sql
            styled
            svelte
            templ
            terraform
            toml
            tsx
            typescript
            vim
            vimdoc
            vue
            yaml
            zig
          ]));
        }

        # the actual config
        laurynas
      ]);

      extraLuaConfig = ''
        require("laurynas")
      '';
    };

  xdg.configFile = {
    "nvim/after" = {
      source = ./after;
      recursive = true;
    };
    "nvim/snippets" = {
      source = ./snippets;
      recursive = true;
    };
  };
}
