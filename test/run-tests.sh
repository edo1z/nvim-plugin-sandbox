#!/bin/bash

# テストスクリプト
set -e

echo "=== Neovim Plugin Sandbox Tests ==="

# カラー定義
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# テスト結果を記録
FAILED=0

# テスト関数
run_test() {
    local description="$1"
    local command="$2"
    
    echo -n "Testing: $description... "
    
    if eval "$command" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASS${NC}"
    else
        echo -e "${RED}✗ FAIL${NC}"
        FAILED=$((FAILED + 1))
    fi
}

# Dockerが起動しているか確認
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running"
    exit 1
fi

# コンテナをビルド
echo "Building containers..."
docker-compose build

# 各バージョンのテスト
for version in 0.10 0.11 nightly; do
    echo ""
    echo "=== Testing Neovim $version ==="
    
    # 基本起動テスト
    run_test "Basic startup" \
        "docker-compose run --rm --entrypoint sh nvim-$version -c 'nvim --version && echo SUCCESS'"
    
    # バージョン確認
    run_test "Version check" \
        "docker-compose run --rm --entrypoint nvim nvim-$version --version"
    
    # minimal設定テスト
    run_test "Minimal config" \
        "NVIM_CONFIG=minimal docker-compose run --rm --entrypoint sh nvim-$version -c 'nvim -u /configs/minimal.lua --headless +qa && echo SUCCESS'"
    
    # full設定テスト
    run_test "Full config" \
        "NVIM_CONFIG=full docker-compose run --rm --entrypoint sh nvim-$version -c 'nvim -u /configs/full.lua --headless +qa && echo SUCCESS'"
    
    # プラグインロードテスト
    run_test "Plugin loading" \
        "PLUGIN_PATH=./test/test-plugin docker-compose run --rm --entrypoint sh nvim-$version -c 'nvim -u /configs/minimal.lua --headless -c \"echo exists(\\\"g:test_plugin_loaded\\\")\" -c \"qa\"'"
    
    # コマンド実行テスト
    run_test "Plugin command" \
        "PLUGIN_PATH=./test/test-plugin docker-compose run --rm --entrypoint sh nvim-$version -c 'nvim -u /configs/minimal.lua --headless -c \"TestPluginInfo\" -c \"qa!\"'"
done

# スクリプトテスト
echo ""
echo "=== Testing scripts ==="
run_test "test-plugin.sh exists" "test -f ./scripts/test-plugin.sh"
run_test "test-plugin.sh is executable" "test -x ./scripts/test-plugin.sh"

# 結果サマリー
echo ""
echo "==================================="
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${RED}$FAILED tests failed${NC}"
    exit 1
fi