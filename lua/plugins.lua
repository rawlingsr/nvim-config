local M = {
    -- THEME
    "nvim-tree/nvim-web-devicons",
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.api.nvim_command('colorscheme tokyonight-storm')
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = { theme = 'tokyonight' },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
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
        },
        opts = {
            window = {
                mappings = {
                    ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
                    ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
                    ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
                },
            },
        }
    },

    -- GIT
    'tpope/vim-fugitive',
    'junegunn/gv.vim',
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
    },

    -- LIBS
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release ' ..
            '&& cmake --build build --config Release ' ..
            '&& cmake --install build --prefix build'
    },
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
    },
    {
        "akinsho/toggleterm.nvim",
        tag = 'v2.7.1',
        opts = {
            open_mapping = '<C-\\>',
            start_in_insert = true,
            direction = 'float',
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "javascript",
                    "typescript",
                    "tsx",
                    "html",
                    "css",
                    "rust",
                },
                sync_install = false,
                highlight = { enable = true },
            })
        end
    },

    -- Language servers
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            local lspconfig = require('lspconfig')
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "denols",
                    "tsserver",
                    "lua_ls",
                    "rust_analyzer",
                    "html",
                    "cssls",
                    "jsonls",
                    "rubocop",
                    "pyright",
                    "dockerls",
                    "eslint",
                    "angularls",
                    "bashls",
                    "docker_compose_language_service",
                    "gradle_ls",
                    "ruby_ls",
                },
            })
            require("mason-lspconfig").setup_handlers {
                function(server_name)
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
                    lspconfig.lua_ls.setup {
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
    },
}

return M
