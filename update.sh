#!/bin/bash
# Universal update script for claw-search
# Uninstalls and redeploys with latest configuration

set -e

# Support non-interactive mode via environment variable or --yes flag
INTERACTIVE=${INTERACTIVE:-true}
if [[ "$1" == "--yes" ]] || [[ "$1" == "-y" ]]; then
    INTERACTIVE=false
fi

echo "🔄 claw-search Update Script"
echo "================================="
echo "This will:"
echo "  1. Uninstall current installation"
echo "  2. Redeploy with latest configuration"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check if uninstall.sh exists
if [ ! -f "./uninstall.sh" ]; then
    echo -e "${RED}❌ uninstall.sh not found${NC}"
    exit 1
fi

# Check if deploy.sh exists
if [ ! -f "./deploy.sh" ]; then
    echo -e "${RED}❌ deploy.sh not found${NC}"
    exit 1
fi

# Check if anything is installed
if ! podman ps -a | grep -q searxng && ! openclaw plugins list 2>/dev/null | grep -q claw-search; then
    echo -e "${YELLOW}⚠️  Nothing to update${NC}"
    echo "Run ./deploy.sh to install."
    exit 0
fi

# Confirm with user in interactive mode
if [ "$INTERACTIVE" = "true" ]; then
    echo -e "${YELLOW}⚠️  Warning: This will uninstall and reinstall everything${NC}"
    echo -n "Continue? (y/N): "
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Update cancelled."
        exit 0
    fi
fi

echo ""
echo "📦 Step 1: Uninstalling..."
INTERACTIVE=false bash ./uninstall.sh

echo ""
echo "📦 Step 2: Redeploying with latest configuration..."
bash ./deploy.sh

echo ""
echo "================================="
echo -e "${GREEN}✨ Update complete!${NC}"
echo ""
echo -e "${BLUE}Tip:${NC} Run ./test-chinese.sh to verify Chinese search capability"
