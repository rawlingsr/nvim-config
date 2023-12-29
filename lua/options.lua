local opt = vim.opt

-- Context
opt.colorcolumn = '120' -- Highlight nth column
opt.number = true
opt.relativenumber = true
opt.scrolloff = 4 -- How close curser can get to the edge
opt.signcolumn = 'yes'

-- Theme
-- opt.guifont = 'SauceCodePro_Nerd_Font,Fira_Code,Source_Code_Pro,Consolas,Mono:h12'
opt.guifont = {
    'Hack_Nerd_Font',
    'SauceCodePro_Nerd_Font',
    'Fira_Code',
    'Source_Code_Pro',
    -- 'Consolas',
    ':h12'
}
opt.syntax = 'ON' -- Syntax highlighting based on file type.
opt.termguicolors = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Whitespace
opt.expandtab = true -- use spaces for indentation
opt.list = true
-- opt.listchars:append "eol:↴"
opt.listchars:append "nbsp:+"
opt.listchars:append "space:⋅"
opt.shiftround = true
opt.shiftwidth = 0 -- Use tabstop as number of spaces to shift by
opt.tabstop = 4

-- System
-- opt.shellslash = true
