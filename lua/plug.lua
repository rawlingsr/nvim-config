local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'git@github.com:wbthomason/packer.nvim.git', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons'}

    -- [[ Theme ]]
    use 'mhinz/vim-startify' 
    use 'nvim-lualine/lualine.nvim'
    use 'Mofiqul/dracula.nvim' 

      -- [[ Dev ]]
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'majutsushi/tagbar'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'tpope/vim-fugitive'
    use 'junegunn/gv.vim'
    use 'windwp/nvim-autopairs'
    -- use {'akinsho/bufferline.nvim', tag = "v4.3.0", requires = 'nvim-tree/nvim-web-devicons'}

    if packer_bootstrap then
        require('packer').sync()
    end
end)
