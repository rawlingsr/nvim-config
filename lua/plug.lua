local cmd = vim.api.nvim_command
return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}

    use {
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-tree').setup{
                git = { ignore = false },
                -- cmd('colorscheme dracula'),
            }
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = 'Mofiqul/dracula.nvim',
        config = function()
            require('lualine').setup{
                options = {
                    theme = 'dracula-nvim'
                }
            }
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        requires = 'nvim-lua/plenary.nvim',
    }

    use {
        "akinsho/toggleterm.nvim",
        tag = 'v2.7.1',
        config = function()
            require("toggleterm").setup{
                open_mapping = '<C-\\>',
                start_in_insert = true,
                direction = 'float',
            }
        end
    }

    use {
        'lukas-reineke/indent-blankline.nvim',
        tag = 'v2.20.7',
        config = function()
            require("indent_blankline").setup {
                show_end_of_line = true,
                space_char_blankline = " ",
            }
        end
    }
    -- use {'tpope/vim-fugitive'}
    -- use {'junegunn/gv.vim'}
    -- use {'windwp/nvim-autopairs'}
    -- require('nvim-autopairs').setup{}
    -- use {'lewis6991/gitsigns.nvim'}
    -- require('gitsigns').setup()
    -- use {'akinsho/bufferline.nvim', tag = "v4.3.0", requires = 'nvim-tree/nvim-web-devicons'}
    -- require("bufferline").setup{}

    use {'mhinz/vim-startify', disable = true}
    use {'majutsushi/tagbar', disable = true}

end)
