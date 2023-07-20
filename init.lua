local cmd = vim.api.nvim_command
local shell_options = {}
if vim.fn.executable "pwsh" == 1 then
    shell_options = {
        shell = "pwsh",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
    }
end

for option, value in pairs(shell_options) do
    vim.opt[option] = value
end

--Rip this out when nvim tree goes
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader
vim.g.mapleader = ','
vim.g.localleader = '\\'

-- Imports
require('vars')
require('opts')
require('plug')
require('keys')

-- PLUGINS
require('nvim-tree').setup({
    git = { ignore = false },
    cmd('colorscheme dracula'),

})

require('lualine').setup{
    options = {
        theme = 'dracula-nvim'
    }
}

vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
}
-- require("bufferline").setup{}
require('nvim-autopairs').setup{}
require('gitsigns').setup()
require("toggleterm").setup({
    open_mapping = '<C-\\>',
    start_in_insert = true,
    direction = 'float',
})
require('Comment').setup()

