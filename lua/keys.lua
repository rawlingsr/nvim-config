local map = vim.keymap.set

-- I couldn't find a lua way to open neotree
map('n', '<leader>/', ":Neotree toggle<CR>", {desc = "open neotree"})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    local desc = function(description)
        local opts = {}
        opts.desc = description
        opts.buffer = ev.buf
        return opts
    end

    map('n', 'gD', vim.lsp.buf.declaration, desc("Go to Declaration"))
    map('n', 'gd', vim.lsp.buf.definition, desc("Go to Definition"))
    map('n', 'K', vim.lsp.buf.hover, desc("Hover"))
    map('n', 'gi', vim.lsp.buf.implementation, desc("Go to Implementation"))
    map('n', '<C-k>', vim.lsp.buf.signature_help, desc("Signature help"))
    map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, desc("Add workspace folder"))
    map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, desc("Remove workspace folder"))
    map('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, desc("List workspace folders"))
    map('n', '<leader>D', vim.lsp.buf.type_definition, desc("Show Type Definition"))
    map('n', '<leader>rn', vim.lsp.buf.rename, desc("LS rename"))
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, desc("Code actions"))
    map('n', 'gr', vim.lsp.buf.references, desc("Get References?"))
    map('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, desc("Format Document"))
  end,
})
