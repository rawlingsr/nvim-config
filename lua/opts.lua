local opt = vim.opt

-- [[ Context ]]
opt.colorcolumn = '120'
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4
opt.signcolumn = 'yes'

-- [[ Theme ]]
opt.guifont = 'Source Code Pro Nerd Font:12'
opt.syntax = 'ON'
opt.termguicolors = true

-- [[ Search ]]
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- [[ Whitespace ]]
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.list = true
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"

