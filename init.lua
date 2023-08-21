local shell_options = {}
if vim.fn.executable "pwsh" == 1 then
    shell_options = {
        shell = "pwsh",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
    }
end

for option, value in pairs(shell_options) do
    vim.opt[option] = value
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Leader
vim.g.mapleader = ','
vim.g.localleader = '\\'

-- Imports
require('vars')
require('opts')
require('plug')
require('keys')

