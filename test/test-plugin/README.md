# Test Plugin

このプラグインは、Neovim Plugin Sandboxのテスト用ダミープラグインです。

## 機能

- `vim.g.test_plugin_loaded`: プラグインがロードされたかを確認
- `vim.g.test_plugin_version`: プラグインのバージョン
- `:TestPluginInfo`: プラグイン情報を表示するコマンド

## テスト方法

```vim
" プラグインがロードされているか確認
:echo g:test_plugin_loaded

" プラグイン情報を表示
:TestPluginInfo
```