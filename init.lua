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

--Rip this out when nvim tree goes
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader
vim.g.mapleader = ','
vim.g.localleader = '\\'

-- Imports
require('vars')
require('opts')
require('plug')
require('keys')

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'git@github.com:wbthomason/packer.nvim.git', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

if packer_bootstrap then
    require('packer').sync()
end
