-- [[ keys.lua ]]

local map = vim.api.nvim_set_keymap

-- remap the key used to leave insert mode
-- map('i', 'jk', '<Esc>', {})

-- I'll probably remove nvim tree and replace with neotree
local api = require "nvim-tree.api"
map('n', 'n', '', {callback = function()
  api.tree.toggle({})
end
})
