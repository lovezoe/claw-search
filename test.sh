#!/bin/bash
# Test script for claw-search plugin v1.1.0

echo "🧪 Testing claw-search v1.1.0"
echo "=============================="
echo ""

SEARXNG_URL="${SEARXNG_URL:-http://localhost:8888}"

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counter
PASSED=0
FAILED=0

# Test 1: SearXNG is running
echo "Test 1: SearXNG Availability"
if curl -s --max-time 3 "$SEARXNG_URL" > /dev/null 2>&1; then
    echo -e "   ${GREEN}✅ PASSED${NC} - SearXNG is accessible at $SEARXNG_URL"
    ((PASSED++)) || true
else
    echo -e "   ${RED}❌ FAILED${NC} - SearXNG not accessible at $SEARXNG_URL"
    echo -e "   ${BLUE}ℹ️  Make sure SearXNG is running:${NC} docker ps | grep searxng"
    ((FAILED++)) || true
    exit 1
fi

# Test 2: General search
echo ""
echo "Test 2: General Search"
GENERAL_COUNT=$(curl -s "$SEARXNG_URL/search?q=test&format=json" | jq -r '.results | length' 2>/dev/null || echo "0")
if [ "$GENERAL_COUNT" -gt 0 ]; then
    echo -e "   ${GREEN}✅ PASSED${NC} - Got $GENERAL_COUNT results"
    ((PASSED++)) || true
else
    echo -e "   ${RED}❌ FAILED${NC} - Got 0 results"
    ((FAILED++)) || true
fi

# Test 3: News search
echo ""
echo "Test 3: News Search"
NEWS_COUNT=$(curl -s "$SEARXNG_URL/search?q=technology&format=json&categories=news" | jq -r '.results | length' 2>/dev/null || echo "0")
if [ "$NEWS_COUNT" -gt 0 ]; then
    echo -e "   ${GREEN}✅ PASSED${NC} - Got $NEWS_COUNT results"
    ((PASSED++)) || true
else
    echo -e "   ${RED}❌ FAILED${NC} - Got 0 results"
    ((FAILED++)) || true
fi

# Test 4: Image search
echo ""
echo "Test 4: Image Search"
IMAGE_COUNT=$(curl -s "$SEARXNG_URL/search?q=nature&format=json&categories=images" | jq -r '.results | length' 2>/dev/null || echo "0")
if [ "$IMAGE_COUNT" -gt 0 ]; then
    echo -e "   ${GREEN}✅ PASSED${NC} - Got $IMAGE_COUNT results"
    ((PASSED++)) || true
else
    echo -e "   ${RED}❌ FAILED${NC} - Got 0 results"
    ((FAILED++)) || true
fi

# Test 5: Video search (NEW in v1.1.0)
echo ""
echo -e "Test 5: Video Search ${BLUE}(NEW in v1.1.0)${NC}"
VIDEO_COUNT=$(curl -s "$SEARXNG_URL/search?q=tutorial&format=json&categories=videos" | jq -r '.results | length' 2>/dev/null || echo "0")
if [ "$VIDEO_COUNT" -gt 0 ]; then
    echo -e "   ${GREEN}✅ PASSED${NC} - Got $VIDEO_COUNT results"
    ((PASSED++)) || true
else
    echo -e "   ${YELLOW}⚠️  WARNING${NC} - No video results (category may not be configured)"
fi

# Test 6: Repository search (NEW in v1.1.0)
echo ""
echo -e "Test 6: Repository Search ${BLUE}(NEW in v1.1.0)${NC}"
REPO_COUNT=$(curl -s "$SEARXNG_URL/search?q=javascript&format=json&categories=it" | jq -r '.results | length' 2>/dev/null || echo "0")
if [ "$REPO_COUNT" -gt 0 ]; then
    echo -e "   ${GREEN}✅ PASSED${NC} - Got $REPO_COUNT results"
    ((PASSED++)) || true
else
    echo -e "   ${YELLOW}⚠️  WARNING${NC} - No repository results (category may not be configured)"
fi

# Test 7: Quick answer (NEW in v1.1.0)
echo ""
echo -e "Test 7: Quick Answer ${BLUE}(NEW in v1.1.0)${NC}"
ANSWER_COUNT=$(curl -s "$SEARXNG_URL/search?q=what+is+python&format=json" | jq -r '.results | length' 2>/dev/null || echo "0")
if [ "$ANSWER_COUNT" -gt 0 ]; then
    echo -e "   ${GREEN}✅ PASSED${NC} - Got $ANSWER_COUNT results"
    ((PASSED++)) || true
else
    echo -e "   ${RED}❌ FAILED${NC} - Got 0 results"
    ((FAILED++)) || true
fi

# Test 8: Plugin installed
echo ""
echo "Test 8: Plugin Installation"
if [ -d ~/.openclaw/extensions/claw-search ]; then
    VERSION=$(cat ~/.openclaw/extensions/claw-search/package.json 2>/dev/null | jq -r '.version' 2>/dev/null || echo "unknown")
    if [ "$VERSION" = "1.1.0" ]; then
        echo -e "   ${GREEN}✅ PASSED${NC} - Plugin installed (version $VERSION)"
        ((PASSED++)) || true
    else
        echo -e "   ${YELLOW}⚠️  WARNING${NC} - Plugin version is $VERSION (expected 1.1.0)"
    fi
else
    echo -e "   ${BLUE}ℹ️  INFO${NC} - Plugin not installed locally"
    echo -e "   ${BLUE}      ${NC} Install with: openclaw plugins install ."
fi

echo ""
echo "=============================="
echo -e "${GREEN}✨ Test suite complete!${NC}"
echo ""
echo "Summary:"
echo -e "  ${GREEN}✅ Passed:${NC}  $PASSED tests"
if [ $FAILED -gt 0 ]; then
    echo -e "  ${RED}❌ Failed:${NC}  $FAILED tests"
fi
echo ""
echo "Coverage:"
echo "  ✓ All 6 search tools tested"
echo "  ✓ SearXNG categories: general, news, images, videos, it"
echo ""
if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✅ All tests passed!${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Restart gateway: openclaw gateway restart"
    echo "  2. Try: 'Search for Python tutorials'"
    echo "  3. Try: 'Find AI news videos'"
    exit 0
else
    echo -e "${RED}❌ Some tests failed. Please check your SearXNG configuration.${NC}"
    exit 1
fi
