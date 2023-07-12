local map = vim.api.nvim_set_keymap

local api = require "nvim-tree.api"
map('n', '<Leader>n', '', {callback = function()
  api.tree.toggle({})
end
})

map('n', '<Leader>m', '', {callback = function()
  api.tree.focus({})
end
})
