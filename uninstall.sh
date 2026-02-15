#!/bin/bash
# Uninstall script for claw-search

# Support non-interactive mode
INTERACTIVE=${INTERACTIVE:-true}

echo "🗑️  claw-search Uninstall Script"
echo "================================="
echo ""

# Uninstall plugin
echo "📦 Step 1: Uninstalling plugin..."
rm -rf ~/.openclaw/extensions/claw-search
echo "✅ Plugin removed"

# Clean config
echo ""
echo "📦 Step 2: Cleaning configuration..."
if command -v jq &> /dev/null; then
    cat ~/.openclaw/openclaw.json | jq 'del(.plugins.entries["claw-search"])' > /tmp/config.json
    mv /tmp/config.json ~/.openclaw/openclaw.json
    echo "✅ Configuration cleaned"
else
    echo "⚠️  jq not found, skip config cleanup (manual edit needed)"
fi

# Handle SearXNG removal
echo ""
if [ "$INTERACTIVE" = "true" ]; then
    read -p "Do you want to stop and remove SearXNG container? (y/N) " -n 1 -r
    echo
    REMOVE_CONTAINER=$REPLY
else
    # Non-interactive mode: remove container by default
    REMOVE_CONTAINER="y"
fi

if [[ $REMOVE_CONTAINER =~ ^[Yy]$ ]]; then
    sudo docker stop searxng 2>/dev/null || true
    sudo docker rm searxng 2>/dev/null || true
    echo "✅ SearXNG container removed"
    
    if [ "$INTERACTIVE" = "true" ]; then
        read -p "Remove SearXNG data volume? (y/N) " -n 1 -r
        echo
        REMOVE_VOLUME=$REPLY
    else
        REMOVE_VOLUME="n"
    fi
    
    if [[ $REMOVE_VOLUME =~ ^[Yy]$ ]]; then
        sudo docker volume rm searxng-config 2>/dev/null || true
        echo "✅ SearXNG volume removed"
    fi
else
    echo "ℹ️  SearXNG container kept running"
fi

echo ""
echo "================================="
echo "✨ Uninstall complete!"
echo ""
echo "To reinstall: ./deploy.sh"
