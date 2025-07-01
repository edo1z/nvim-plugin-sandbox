-- Minimal configuration for testing plugins
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Disable swap files for testing
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic keymaps for testing
vim.keymap.set('n', '<leader>q', ':qa!<CR>', { desc = 'Quit all' })

-- Load plugins from test directory
vim.opt.runtimepath:append("/root/.local/share/nvim/site/pack/test/start/*")

print("Minimal config loaded. Plugins directory: /root/.local/share/nvim/site/pack/test/start/")