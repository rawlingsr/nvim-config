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

 require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function this_map(mode, l, r, opts)
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
        this_map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, desc("Next hunk", { expr = true }))

        this_map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, desc("Previous hunk", { expr = true }))

        -- Actions
        this_map('n', '<leader>hs', gs.stage_hunk, desc("Stage hunk"))
        this_map('n', '<leader>hr', gs.reset_hunk, desc("Reset hunk"))
        this_map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            desc("Stage hunk"))
        this_map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            desc("Reset hunk"))
        this_map('n', '<leader>hS', gs.stage_buffer, desc("Stage buffer"))
        this_map('n', '<leader>hu', gs.undo_stage_hunk, desc("Undo stage hunk"))
        this_map('n', '<leader>hR', gs.reset_buffer, desc("Reset buffer"))
        this_map('n', '<leader>hp', gs.preview_hunk, desc("Preview hunk"))
        this_map('n', '<leader>hb', function() gs.blame_line { full = true } end, desc("Blame Line"))
        this_map('n', '<leader>tb', gs.toggle_current_line_blame, desc("Toggle blame current line"))
        this_map('n', '<leader>hd', gs.diffthis, desc("Show unstaged diff"))
        this_map('n', '<leader>hD', function() gs.diffthis('~') end, desc("Show staged diff"))
        this_map('n', '<leader>td', gs.toggle_deleted, desc("Show/Hide deleted lines"))

        this_map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', desc("Select current hunk"))
    end
}
