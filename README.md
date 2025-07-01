# Neovim Plugin Sandbox

複数バージョンのNeovimでプラグインをテストするためのDocker環境です。

## 特徴

- Neovim 0.10, 0.11, Nightly版を簡単に切り替え可能
- ローカルのプラグインを即座にテスト
- 最小限の設定と完全な設定を用意
- 他の環境に影響を与えない隔離環境

## 必要なもの

- Docker
- Docker Compose

## 使い方

### 基本的な使い方

```bash
# プラグインディレクトリをpluginsフォルダにコピーまたはシンボリックリンク
ln -s ~/my-awesome-plugin ./plugins/

# Neovim 0.11でテスト
docker-compose run --rm nvim-0.11

# Neovim 0.10でテスト
docker-compose run --rm nvim-0.10

# Nightly版でテスト
docker-compose run --rm nvim-nightly
```

### 環境変数を使った方法

```bash
# 特定のプラグインをテスト
PLUGIN_PATH=~/my-plugin docker-compose run --rm nvim-0.11

# フル設定でテスト
NVIM_CONFIG=full PLUGIN_PATH=~/my-plugin docker-compose run --rm nvim-0.11
```

### スクリプトを使った方法

```bash
# プラグインパス、バージョン、設定を指定
./scripts/test-plugin.sh ~/my-plugin 0.11 full

# デフォルト（現在のディレクトリ、0.11、minimal設定）
./scripts/test-plugin.sh
```

### .bashrcにエイリアスを設定

開発中のプラグインディレクトリで簡単にテストできるようにエイリアスを設定：

```bash
# ~/.bashrcに追加（パスは環境に合わせて調整）
alias nvim-plugin-test='~/nvim-plugin-sandbox/scripts/test-plugin.sh'

# 使い方：プラグインディレクトリで実行
cd ~/my-awesome-plugin
nvim-plugin-test                    # 現在のディレクトリ、0.11、minimal設定
nvim-plugin-test . 0.10             # 現在のディレクトリ、0.10、minimal設定
nvim-plugin-test . 0.11 full        # 現在のディレクトリ、0.11、full設定
nvim-plugin-test . nightly full     # 現在のディレクトリ、nightly、full設定
```

## 設定ファイル

### minimal.lua
- 基本的な設定のみ
- プラグインのテストに必要最小限

### full.lua
- より実用的な設定
- 一般的なキーマッピング付き
- `<leader>p`で読み込まれたプラグイン一覧を表示

### プラグイン固有の設定ファイル

多くの最近のNeovimプラグインは`setup()`関数の呼び出しが必要です。プラグインが自動的に動作しない場合は、専用の設定ファイルを作成してください：

```lua
-- configs/my-plugin.lua の例
---@diagnostic disable-next-line: undefined-global
local vim = vim

-- 基本設定
vim.g.mapleader = " "
vim.opt.number = true

-- プラグインのセットアップ
local ok, my_plugin = pcall(require, 'my-plugin')
if ok then
  my_plugin.setup({
    -- プラグイン固有のオプション
    option1 = true,
    option2 = "value"
  })
  print("My-plugin loaded successfully!")
else
  print("Failed to load my-plugin:", my_plugin)
end
```

使用方法：
```bash
# プラグインディレクトリで実行
nvim-plugin-test . 0.11 my-plugin
```

## カスタマイズ

### 複数のプラグインを同時にテスト

`docker-compose.override.yml`を作成：

```yaml
services:
  nvim-0.11:
    volumes:
      - ~/plugins/plugin1:/root/.local/share/nvim/site/pack/test/start/plugin1
      - ~/plugins/plugin2:/root/.local/share/nvim/site/pack/test/start/plugin2
```

### 独自の設定を追加

`configs/`ディレクトリに新しい設定ファイルを追加：

```bash
# configs/custom.lua を作成
NVIM_CONFIG=custom docker-compose run --rm nvim-0.11
```

## トラブルシューティング

### プラグインが読み込まれない
- プラグインのディレクトリ構造を確認（`lua/`や`plugin/`が含まれているか）
- `:scriptnames`でロードされたファイルを確認
- `<leader>p`で読み込まれたプラグインを確認（full設定時）

### パーミッションエラー
- Dockerがファイルにアクセスできることを確認
- 必要に応じて`chmod`で権限を調整

## ライセンス

MIT
