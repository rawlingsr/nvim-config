return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}


    use {
        "williamboman/mason-lspconfig.nvim",
        requires = { {"williamboman/mason.nvim"}, {"neovim/nvim-lspconfig"} },
        config = function()
            local lspconfig = require('lspconfig')
            require("mason").setup()
            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers {
                function (server_name)
                    require("lspconfig")[server_name].setup {}
                end,

                ["denols"] = function()
                    lspconfig.denols.setup {
                        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
                    }
                end,

                ["tsserver"] = function()
                    lspconfig.tsserver.setup {
                        root_dir = lspconfig.util.root_pattern("package.json"),
                        single_file_support = false
                    }
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup{
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' }
                                }
                            }
                        }
                    }
                end
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
        commit = 'bae45ef449d8811061cc940459e70e883a3aa83a',
        config = function() require('gitsigns').setup{
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                local function desc(description, opts)
                    opts = opts or {}
                    opts.desc = description
                    return opts
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, desc("Next hunk", {expr=true}))

                map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, desc("Previous hunk", {expr=true}))

                -- Actions
                map('n', '<leader>hs', gs.stage_hunk, desc("Stage hunk"))
                map('n', '<leader>hr', gs.reset_hunk, desc("Reset hunk"))
                map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc("Stage hunk"))
                map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, desc("Reset hunk"))
                map('n', '<leader>hS', gs.stage_buffer, desc("Stage buffer"))
                map('n', '<leader>hu', gs.undo_stage_hunk, desc("Undo stage hunk"))
                map('n', '<leader>hR', gs.reset_buffer, desc("Reset buffer"))
                map('n', '<leader>hp', gs.preview_hunk, desc("Preview hunk"))
                map('n', '<leader>hb', function() gs.blame_line{full=true} end, desc("Blame Line"))
                map('n', '<leader>tb', gs.toggle_current_line_blame, desc("Toggle blame current line"))
                map('n', '<leader>hd', gs.diffthis, desc("Show unstaged diff"))
                map('n', '<leader>hD', function() gs.diffthis('~') end, desc("Show staged diff"))
                map('n', '<leader>td', gs.toggle_deleted, desc("Show/Hide deleted lines"))

                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', desc("Select current hunk"))
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
