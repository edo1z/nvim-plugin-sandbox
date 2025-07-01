---@diagnostic disable-next-line: undefined-global
local vim = vim

-- テスト用のシンプルなプラグイン
vim.g.test_plugin_loaded = true
vim.g.test_plugin_version = "1.0.0"

-- テスト用のコマンド
vim.api.nvim_create_user_command('TestPluginInfo', function()
  vim.notify('Test Plugin v' .. vim.g.test_plugin_version .. ' is loaded!', vim.log.levels.INFO)
end, {})

-- 起動時のメッセージ（デバッグ用）
if vim.env.DEBUG_TEST_PLUGIN then
  vim.notify('Test plugin initialized', vim.log.levels.DEBUG)
end