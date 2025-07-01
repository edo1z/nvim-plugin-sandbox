#!/bin/bash

# Usage: ./test-plugin.sh <plugin-path> [nvim-version] [config]
# Example: ./test-plugin.sh ~/my-plugin 0.11 full

PLUGIN_PATH="${1:-.}"
NVIM_VERSION="${2:-0.11}"
CONFIG="${3:-minimal}"

# Resolve absolute path
PLUGIN_PATH=$(realpath "$PLUGIN_PATH")
PLUGIN_NAME=$(basename "$PLUGIN_PATH")

if [ ! -d "$PLUGIN_PATH" ]; then
    echo "Error: Plugin path '$PLUGIN_PATH' does not exist"
    exit 1
fi

echo "Testing plugin: $PLUGIN_PATH"
echo "Plugin name: $PLUGIN_NAME"
echo "Parent directory: $(dirname "$PLUGIN_PATH")"
echo "Neovim version: $NVIM_VERSION"
echo "Config: $CONFIG"
echo ""

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Get parent directory of the plugin (e.g., plugins/)
PLUGIN_PARENT_DIR=$(dirname "$PLUGIN_PATH")

# Run the container with the plugin mounted
cd "$PROJECT_ROOT" && \
PLUGIN_PATH="$PLUGIN_PARENT_DIR" \
NVIM_CONFIG="$CONFIG" \
docker-compose run --rm "nvim-${NVIM_VERSION}"