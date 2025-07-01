-- Configuration specifically for testing hoge plugin
---@diagnostic disable-next-line: undefined-global
local vim = vim

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load and setup hoge plugin
local ok, hoge = pcall(require, 'hoge')
if ok then
  hoge.setup()
  print("Hoge plugin loaded and setup completed!")
  print("Press <leader>L to open Hoge UI")
else
  print("Failed to load hoge plugin:", hoge)
end

-- Basic keymaps
vim.keymap.set('n', '<leader>q', ':qa!<CR>', { desc = 'Quit all' })