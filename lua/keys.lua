local map = vim.api.nvim_set_keymap

local api = require "nvim-tree.api"
map('n', '<Leader>n', '', {callback = function()  api.tree.toggle({}) end })

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    local desc = function(description)
        opts.desc = description
        return opts
    end

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, desc("Go to Declaration"))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, desc("Go to Definition"))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, desc("Hover"))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, desc("Go to Implementation"))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc("Signature help"))
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, desc("Add workspace folder"))
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, desc("Remove workspace folder"))
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, desc("List workspace folders"))
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, desc("Show Type Definition"))
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, desc("LS rename"))
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, desc("Code actions"))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, desc("Get References?"))
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, desc("Format Document"))
  end,
})
