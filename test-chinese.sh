#!/bin/bash
# Test script for Chinese search capability
# Compares search results quality between different categories

set -e

echo "🧪 Chinese Search Capability Test"
echo "================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

BASE_URL="http://localhost:8888"

# Check if SearXNG is running
if ! curl -s --max-time 5 "$BASE_URL" > /dev/null 2>&1; then
    echo -e "${RED}❌ SearXNG is not accessible at $BASE_URL${NC}"
    echo "Please make sure SearXNG is running (./deploy.sh)"
    exit 1
fi

echo -e "${GREEN}✅ SearXNG is accessible${NC}"
echo ""

# Test function
test_search() {
    local query="$1"
    local category="$2"
    local description="$3"
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${BLUE}Test: $description${NC}"
    echo "Query: $query"
    echo "Category: $category"
    echo ""
    
    local url="$BASE_URL/search?q=$(echo "$query" | jq -sRr @uri)&format=json"
    if [ -n "$category" ]; then
        url="$url&categories=$category"
    fi
    
    local response=$(curl -s "$url")
    local count=$(echo "$response" | jq -r '.results | length' 2>/dev/null || echo "0")
    
    echo -e "Results count: ${GREEN}$count${NC}"
    
    if [ "$count" -gt 0 ]; then
        echo ""
        echo "Top 5 sources:"
        echo "$response" | jq -r '.results[0:5] | .[] | "  • \(.url | sub("https?://"; "") | split("/")[0])"' 2>/dev/null || echo "  (unable to parse)"
        
        echo ""
        echo "Sample titles:"
        echo "$response" | jq -r '.results[0:3] | .[] | "  \(.title)"' 2>/dev/null | head -3
    else
        echo -e "${YELLOW}⚠️  No results found${NC}"
    fi
    
    echo ""
}

# Test 1: English search (baseline)
test_search "DeepSeek V4" "" "English general search"

# Test 2: Chinese search in general category
test_search "深度求索" "" "Chinese general search"

# Test 3: Chinese news search
test_search "DeepSeek V4" "news" "English news search"

# Test 4: Chinese news search
test_search "智谱 GLM-5" "news" "Chinese news search"

# Test 5: Chinese tech search
test_search "人工智能" "" "Chinese AI search"

# Test 6: Repos search
test_search "openclaw github" "it" "Code repository search"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "================================="
echo -e "${GREEN}✅ Tests complete!${NC}"
echo ""
echo "Analysis:"
echo "  - Compare result counts between English and Chinese queries"
echo "  - Check if Chinese sources (baidu.com, sogou.com, etc.) appear"
echo "  - Verify news category returns relevant Chinese news sites"
echo ""
echo -e "${BLUE}Tip:${NC} If Chinese results are poor, check:"
echo "  1. Run: sudo docker exec searxng grep 'name: baidu' -A 5 /etc/searxng/settings.yml"
echo "  2. Verify 'disabled: false' for baidu, sogou, bing"
echo "  3. Try: ./update.sh to redeploy with latest config"
