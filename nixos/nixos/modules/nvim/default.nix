# Neovim (Home Manager module). Imported from modules/user/common.nix.
{ pkgs, ... }:
let
  # Lua config files. Named *-lua so they never shadow a plugin name inside
  # `with pkgs.vimPlugins; [ … ]` (a `let` binding beats `with`).
  settings-lua = ./lua/settings.lua;
  remap-lua = ./lua/remap.lua;
  telescope-lua = ./lua/plugins/telescope.lua;
  lsp-lua = ./lua/plugins/lsp.lua;
  treesitter-lua = ./lua/plugins/treesitter.lua;
  undotree-lua = ./lua/plugins/undotree.lua;
  harpoon-lua = ./lua/plugins/harpoon.lua;
  neo-tree-lua = ./lua/plugins/neo-tree.lua;

  elixirTools = import ../../lib/elixir.nix pkgs;
in
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    vimAlias = true;

    # harpoon must come after remap (mapleader is set there)
    extraConfig = ''
      luafile ${settings-lua}
      luafile ${remap-lua}
      luafile ${telescope-lua}
      luafile ${lsp-lua}
      luafile ${treesitter-lua}
      luafile ${neo-tree-lua}
      luafile ${undotree-lua}
      luafile ${harpoon-lua}
    '';

    # No plugin uses the Ruby/Python providers
    withRuby = false;
    withPython3 = false;

    # Language servers from Nix, on Neovim's PATH only
    extraPackages = [
      elixirTools.elixir-ls
    ];

    plugins = with pkgs.vimPlugins; [
      {
        # Tokyo Night "night" = the Stylix palette in modules/user/theme.nix
        # (bg #1a1b26, sidebars #16161e). Hardcoded: change this if the desktop palette changes.
        plugin = tokyonight-nvim;
        type = "lua";
        config = ''
          require("tokyonight").setup({ style = "night" })
          vim.cmd.colorscheme("tokyonight-night")
        '';
      }
      vim-nix
      plenary-nvim
      mason-nvim
      mason-lspconfig-nvim
      luasnip
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip
      lsp-zero-nvim
      nvim-treesitter.withAllGrammars
      undotree
      neo-tree-nvim
      harpoon
      friendly-snippets
      {
        plugin = indent-blankline-nvim;
        config = "require('ibl').setup({ indent = { char = '┊' } })";
        type = "lua";
      }
      {
        plugin = telescope-nvim;
        config = "require('telescope').setup()";
        type = "lua";
      }
    ];
  };
}
