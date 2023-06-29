--Rip this out when nvim tree goes
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- Imports
require('vars')
require('opts')
require('plug')
require('keys')

-- PLUGINS
require('nvim-tree').setup{}
require('lualine').setup{
    options = {
        theme = 'dracula-nvim'
    }
}
require('nvim-autopairs').setup{}

