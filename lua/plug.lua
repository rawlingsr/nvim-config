-- [[ plug.lua ]]

return require('packer').startup(function(use)
    use { 'nvim-tree/nvim-tree.lua' }

    -- [[ Theme ]]
    use { 'mhinz/vim-startify' }
    use { 'nvim-lualine/lualine.nvim', }
    use { 'Mofiqul/dracula.nvim' }

      -- [[ Dev ]]
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { 'majutsushi/tagbar' }
    use { 'Yggdroot/indentLine' }
    use { 'tpope/vim-fugitive' }
    use { 'junegunn/gv.vim' }
    use { 'windwp/nvim-autopairs' }
    config = {
        package_root = vim.fn.stdpath('config') .. '/site/pack'
    }
end)
