local opt = vim.opt

vim.cmd [[
    set nowrap
    set nobackup
    set nowritebackup
    set noerrorbells
    set noswapfile
]]

-- Undo files
opt.undofile = true
opt.undodir = "/home/dawgora/.cache/"


-- Indentation
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true


-- clipboard to system clipboard
opt.clipboard = "unnamedplus"


-- use mouse
opt.mouse = "a"


-- Nicer UI
opt.termguicolors = true
opt.cursorline = true
opt.number = true

-- misc

opt.viminfo = ""
opt.viminfofile = "NONE"

opt.smartcase = true
opt.ttimeoutlen = 5
opt.compatible = false
opt.autoread = true
opt.incsearch = true
opt.hidden = true
opt.shortmess = "atI"
