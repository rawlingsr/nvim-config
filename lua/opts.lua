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

-- [[ Whitespace ]]
opt.expandtab = true -- use spaces for indentation
opt.list = true
opt.listchars:append "eol:↴"
opt.listchars:append "nbsp:+"
opt.listchars:append "space:⋅"
opt.listchars:append "trail:X"
opt.shiftwidth = 0 -- Use tabstop as number of spaces to shift by
opt.tabstop = 4
