-- Full configuration with common settings for plugin testing
---@diagnostic disable-next-line: undefined-global
local vim = vim

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Disable swap files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic keymaps
vim.keymap.set('n', '<leader>q', ':qa!<CR>', { desc = 'Quit all' })
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save' })
vim.keymap.set('n', '<leader>e', ':Ex<CR>', { desc = 'Explorer' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Load plugins from test directory
vim.opt.runtimepath:append("/root/.local/share/nvim/site/pack/test/start/*")

-- Helpful for debugging
vim.keymap.set('n', '<leader>p', function()
  print("Loaded plugins:")
  for _, path in ipairs(vim.fn.glob("/root/.local/share/nvim/site/pack/test/start/*", false, true)) do
    print("  - " .. vim.fn.fnamemodify(path, ":t"))
  end
end, { desc = 'List loaded plugins' })

print("Full config loaded. Press <leader>p to list loaded plugins.")

-- Helper function to setup a plugin
vim.keymap.set('n', '<leader>ps', function()
  local plugin_name = vim.fn.input('Plugin name to setup: ')
  if plugin_name ~= '' then
    local ok, plugin = pcall(require, plugin_name)
    if ok and type(plugin.setup) == "function" then
      plugin.setup()
      print("Setup completed for: " .. plugin_name)
    else
      print("Failed to setup: " .. plugin_name)
    end
  end
end, { desc = 'Setup a plugin manually' })