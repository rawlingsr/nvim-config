-- [[ plug.lua ]]

return require('packer').startup(function(use)
    use {
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons'
    }
    
    -- [[ Theme ]]
    use { 'mhinz/vim-startify' }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'nvim-tree/nvim-web-devicons', opt = true}
    }
    use { 'Mofiqul/dracula.nvim' }
    
      -- [[ Dev ]]
    use {
        'nvim-telescope/telescope.nvim',        -- fuzzy finder
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use { 'majutsushi/tagbar' }               -- code structure
    use { 'Yggdroot/indentLine' }             -- see indentation
    use { 'tpope/vim-fugitive' }              -- git integration
    use { 'junegunn/gv.vim' }                 -- commit history
    use { 'windwp/nvim-autopairs' }   
    config = {
        package_root = vim.fn.stdpath('config') .. '/site/pack'
    }
end)
