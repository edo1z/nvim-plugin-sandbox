#!/bin/bash

# Usage: ./test-plugin.sh <plugin-path> [nvim-version] [config]
# Example: ./test-plugin.sh ~/my-plugin 0.11 full

PLUGIN_PATH="${1:-.}"
NVIM_VERSION="${2:-0.11}"
CONFIG="${3:-minimal}"

# Resolve absolute path
PLUGIN_PATH=$(realpath "$PLUGIN_PATH")

if [ ! -d "$PLUGIN_PATH" ]; then
    echo "Error: Plugin path '$PLUGIN_PATH' does not exist"
    exit 1
fi

echo "Testing plugin: $PLUGIN_PATH"
echo "Neovim version: $NVIM_VERSION"
echo "Config: $CONFIG"
echo ""

# Run the container with the plugin mounted
PLUGIN_PATH="$PLUGIN_PATH" \
NVIM_CONFIG="$CONFIG" \
docker-compose run --rm "nvim-${NVIM_VERSION}"