{lib, config, pkgs, ... }:
with lib;
let
    cfg = config.modules.nvim;

    settings = ./lua/settings.lua;
    remap = ./lua/remap.lua;
    telescope = ./lua/plugins/telescope.lua;
    lsp = ./lua/plugins/lsp.lua;
    treesitter = ./lua/plugins/treesitter.lua;
    # undotree = ./lua/plugins/undotree.lua;
    neo-tree = ./lua/plugins/neo-tree.lua;
    # harpoon = ./lua/plugins/harpoon.lua;
in {
	enable = true;
	vimAlias = true;

	extraConfig = ''
	    luafile ${settings}
	    luafile ${remap}
	    luafile ${telescope}
	    luafile ${lsp}
	    luafile ${treesitter}
	    luafile ${neo-tree}
	'';

	##TODO: remove theese
	withRuby = true;
	withPython3 = true;

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
        }];
}
