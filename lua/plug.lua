return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}

    use {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require('lspconfig')
            lspconfig.pyright.setup {}

            lspconfig.denols.setup {
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            }

            lspconfig.tsserver.setup {
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern("package.json"),
                single_file_support = false
            }

            lspconfig.rust_analyzer.setup {
                settings = {
                    ['rust-analyzer'] = {},
                },
            }
        end

    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons', 'Mofiqul/dracula.nvim' },
        config = function()
            require('nvim-tree').setup{
                git = { ignore = false },
                vim.api.nvim_command('colorscheme dracula'),
            }
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = 'Mofiqul/dracula.nvim',
        config = function()
            require('lualine').setup{
                options = { theme = 'dracula-nvim' }
            }
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        config = function()
            require'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
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

    -- Git
    use {
        'tpope/vim-fugitive',
        tag = 'v3.7'
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup{
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true})

                -- Actions
                map('n', '<leader>hs', gs.stage_hunk)
                map('n', '<leader>hr', gs.reset_hunk)
                map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map('n', '<leader>hS', gs.stage_buffer)
                map('n', '<leader>hu', gs.undo_stage_hunk)
                map('n', '<leader>hR', gs.reset_buffer)
                map('n', '<leader>hp', gs.preview_hunk)
                map('n', '<leader>hb', function() gs.blame_line{full=true} end)
                map('n', '<leader>tb', gs.toggle_current_line_blame)
                map('n', '<leader>hd', gs.diffthis)
                map('n', '<leader>hD', function() gs.diffthis('~') end)
                map('n', '<leader>td', gs.toggle_deleted)

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        } end
    }

    use {'junegunn/gv.vim'}

    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup{} end
    }

    use {'mhinz/vim-startify'}

    use {
        'akinsho/bufferline.nvim', 
        disable = true,
        tag = "v4.3.0", 
        requires = 'nvim-tree/nvim-web-devicons',
        config = function() require("bufferline").setup{} end
    }

    use {'majutsushi/tagbar', disable = true}
end)
