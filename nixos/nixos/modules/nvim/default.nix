{lib, config, pkgs, ... }: 
with lib;
let
    cfg = config.modules.nvim;
    jabuti-nvim = pkgs.vimUtils.buildVimPlugin {
        name = "jabuti-nvim";
        src = pkgs.fetchFromGitHub {
            owner = "jabuti-theme";
            repo = "jabuti-nvim";
            rev = "17f1b94cbf1871a89cdc264e4a8a2b3b4f7c76d2";
            sha256 = "sha256-iPjwx/rTd98LUPK1MUfqKXZhQ5NmKx/rN8RX1PIuDFA=";
        };
    };
in {
	enable = true;
	vimAlias = true;
	extraConfig = '' 
	    luafile $NIXOS_HOME_CONFIG/nvim/lua/settings.lua
	    luafile $NIXOS_HOME_CONFIG/nvim/lua/remap.lua
        luafile $NIXOS_HOME_CONFIG/nvim/lua/plugins/telescope.lua
        luafile $NIXOS_HOME_CONFIG/nvim/lua/plugins/lsp.lua
        luafile $NIXOS_HOME_CONFIG/nvim/lua/plugins/treesitter.lua
        luafile $NIXOS_HOME_CONFIG/nvim/lua/plugins/undotree.lua
        luafile $NIXOS_HOME_CONFIG/nvim/lua/plugins/neo-tree.lua
        luafile $NIXOS_HOME_CONFIG/nvim/lua/plugins/harpoon.lua
	'';

	plugins = with pkgs.vimPlugins; [
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
            plugin = jabuti-nvim;
            config = "colorscheme jabuti";
        }
        {
            plugin = indent-blankline-nvim;
            config = "lua require('ibl').setup({indent = {char = '┊'}})";
        }
        {
            plugin = telescope-nvim;
            config = "lua require('telescope').setup()";
        }];
}
