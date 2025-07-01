-- Minimal configuration for testing plugins
---@diagnostic disable-next-line: undefined-global
local vim = vim

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

-- Debug: List plugins
local plugin_dir = "/root/.local/share/nvim/site/pack/test/start/"
local plugins = vim.fn.glob(plugin_dir .. "*", 0, 1)
print("Minimal config loaded. Found plugins:")
for _, plugin in ipairs(plugins) do
  print("  - " .. plugin)
end

-- Note: Some plugins may require manual setup
-- If your plugin needs initialization, you can:
-- 1. Use full.lua config which includes common setup patterns
-- 2. Create a custom config file for your specific plugin
-- 3. Run setup commands manually in Neovim:
--    :lua require('your-plugin').setup()