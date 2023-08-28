local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

plugins = {
    -- THEME
    "nvim-tree/nvim-web-devicons",
    {
        'Mofiqul/dracula.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.api.nvim_command('colorscheme dracula')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = { theme = 'dracula-nvim' },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
            opts = {
                show_end_of_line = true,
                space_char_blankline = " ",
            },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    },


    -- GIT
    'tpope/vim-fugitive',
    'junegunn/gv.vim',

    -- LIBS
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",

    -- CONVENIENCE
    'mhinz/vim-startify',
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
    }


}

require("lazy").setup(plugins)
