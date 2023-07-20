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
    use {'wbthomason/packer.nvim'}
    use {
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use {'mhinz/vim-startify'}
    use {'Mofiqul/dracula.nvim'}
    use {'nvim-lualine/lualine.nvim'}

    use {'numToStr/Comment.nvim'}
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use {"akinsho/toggleterm.nvim", tag = 'v2.7.1'}
    use {'majutsushi/tagbar'}
    use {'lukas-reineke/indent-blankline.nvim'}
    use {'tpope/vim-fugitive'}
    use {'junegunn/gv.vim'}
    use {'windwp/nvim-autopairs'}
    use {'lewis6991/gitsigns.nvim'}
    -- use {'akinsho/bufferline.nvim', tag = "v4.3.0", requires = 'nvim-tree/nvim-web-devicons'}

    if packer_bootstrap then
        require('packer').sync()
    end
end)
