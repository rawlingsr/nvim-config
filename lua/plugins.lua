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

local plugins = {
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
    {
        'lewis6991/gitsigns.nvim',
        opts = {} -- I'd been putting the keymap in here, but I don't want to do that anymore.
    },

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
        config = function ()
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
                    "groovyls",
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

require("lazy").setup(plugins)
