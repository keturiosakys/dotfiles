{ pkgs, ... }: {

  home = {
    packages = with pkgs; [

      biome
      prettierd

      nixpkgs-fmt

      rust-analyzer
      clippy

      stylua
      gopls

      yamlfmt
    ];
  };

  programs.neovim =
    let

      fetchFromGitHub = pkgs.fetchFromGitHub;
      buildVimPlugin = pkgs.vimUtils.buildVimPlugin;

      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";

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
    in
    {
      enable = true;

      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        nodePackages_latest."@astrojs/language-server"
        emmet-language-server
        helm-ls

        lua-language-server
        nil
        tailwindcss-language-server
        terraform-ls
        nodePackages_latest.typescript-language-server
        vscode-langservers-extracted
        yaml-language-server
      ];

      plugins = with pkgs.vimPlugins; [
        {
          plugin = aerial-nvim;
          config = toLuaFile ./plugins/aerial.lua;
        }

        {
          plugin = comment-nvim;
          config = toLua "require(\"Comment\").setup()";
        }

        {
          plugin = dressing-nvim;
          config = toLuaFile ./plugins/dressing.lua;
        }
        {
          plugin = harpoon;
          config = toLuaFile ./plugins/harpoon.lua;
        }
        plenary-nvim
        popup-nvim
        SchemaStore-nvim
        tabular
        nvim-web-devicons
        {
          plugin = todo-comments-nvim;
          config = toLua "require(\"todo-comments\").setup()";
        }
        indent-blankline-nvim
        {
          plugin = gitsigns-nvim;
          config = toLua "require(\"gitsigns\").setup()";
        }
        vim-helm
        # FIXME: mini-move is unavailable
        fidget-nvim
        vim-slime

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

        #LSP
        lspkind-nvim
        conform-nvim
        nvim-navic
        rust-tools-nvim
        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./plugins/lsp/init.lua;
        }

        copilot-cmp
        {
          plugin = copilot-lua;
          config = toLuaFile ./plugins/copilot.lua;
        }


        lsp-status-nvim
        {
          plugin = lualine-nvim;
          config = toLuaFile ./plugins/lualine.lua;
        }

        nui-nvim
        {
          plugin = neo-tree-nvim;
          config = toLuaFile ./plugins/neotree.lua;
        }

        {
          plugin = rose-pine;
          config = toLuaFile ./plugins/rose-pine.lua;
        }

        {
          plugin = smart-splits-nvim;
          config = toLuaFile ./plugins/splits.lua;
        }

        {
          plugin = nvim-surround;
          config = toLua "require(\"nvim-surround\").setup{}";
        }
        telescope-undo-nvim
        telescope-fzf-native-nvim
        {
          plugin = telescope-nvim;
          config = toLuaFile ./plugins/telescope.lua;
        }

        nvim-treesitter-context
        nvim-treesitter-textobjects
        nvim-ts-context-commentstring
        nvim-ts-autotag
        {
          plugin = (nvim-treesitter.withPlugins (plugins: with plugins; [
            astro
            bash
            c
            css
            comment
            dockerfile
            elixir
            go
            haskell
            hcl
            html
            java
            javascript
            json
            jsonnet
            latex
            lua
            markdown
            markdown-inline
            nix
            ocaml
            python
            regex
            ruby
            rust
            scss
            sql
            svelte
            templ
            terraform
            toml
            tsx
            typescript
            vim
            yaml
          ]));
          config = toLuaFile ./plugins/treesitter.lua;
        }
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./lua/g.lua }
        ${builtins.readFile ./lua/options.lua }
        ${builtins.readFile ./lua/keymaps.lua }
        ${builtins.readFile ./lua/autocmds.lua }
      '';
    };

  xdg.configFile = {
    "nvim/lua/utils.lua" = {
      source = ./lua/utils.lua;
    };
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
