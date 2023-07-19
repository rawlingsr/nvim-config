local map = vim.api.nvim_set_keymap

local api = require "nvim-tree.api"
map('n', '<Leader>n', '', {callback = function()
  api.tree.toggle({})
end
})

