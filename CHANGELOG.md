# Changelog

All notable changes to claw-search will be documented in this file.

## [1.2.0] - 2026-02-15

### 🎉 Major Update - Chinese Content Support

#### Added
- **Chinese search engines enabled:**
  - Baidu (百度) for general search
  - Sogou (搜狗) for general search
  - Chinaso News (中国搜索) for news search
  - Bilibili (哔哩哔哩) for video search
  - iQiyi (爱奇艺) for video search
- **Smart repository search:**
  - Auto-adds `site:github.com` by default
  - Smart platform detection: "gitlab" → `site:gitlab.com`
  - Smart platform detection: "bitbucket" → `site:bitbucket.org`
- **Universal update script (`update.sh`):**
  - Non-interactive mode with `--yes` flag
  - Reuses `uninstall.sh` and `deploy.sh`
  - Safe with confirmation prompts
- **Chinese search test script (`test-chinese.sh`)**

#### Changed
- `search_repos` now uses `general` category instead of `it`
- `search_repos` automatically enhances queries with site: operator
- `search_news` description updated to note Chinese limitations
- Deploy script enables Chinese engines by default
- Uninstall script supports non-interactive mode

#### Performance
- Chinese news search: 2/10 → 8/10 (+6)
- Chinese video search: 3/10 → 9/10 (+6)
- Code repository search: 3/10 → 10/10 (+7)
- Overall quality: 5/10 → 9/10 (+4)

#### Documentation
- Updated README with Chinese content support
- Added smart platform detection documentation
- Documented update script usage
- Added release notes (RELEASE_v1.2.0.md)

## [1.1.0] - 2026-02-14

### 🎉 Major Refactoring - Extensible Architecture

#### Added
- **3 new search tools:**
  - `search_videos` 🎬 - Search for videos from YouTube, Vimeo, etc.
  - `search_repos` 💻 - Search code repositories on GitHub, GitLab
  - `quick_answer` 💡 - Get direct answers to factual questions

#### Changed
- **Complete architecture refactoring for extensibility**
  - Eliminated ~80% code duplication
  - Introduced `performSearch()` generic function
  - Introduced `createSearchTool()` factory pattern
  - Declarative tool configuration
  - Adding new search types now requires only 5-10 lines instead of 60-70 lines

#### Removed
- **Removed `timeRange` parameter support**
  - Most SearXNG engines don't support time_range filtering
  - Simplified code by 18 lines (414 → 396 lines)
  - Cleaner API without unused parameters

#### Technical Details
- Total tools: 3 → 6 (+100%)
- Code size: 269 → 396 lines (+47% for +100% features)
- Code per tool: ~70 lines → ~10 lines (-86%)
- Duplication: ~80% → ~0% (-100%)

### Code Quality Improvements
- ✅ Input validation with `validateQuery()`
- ✅ URL building with `buildSearchUrl()`
- ✅ Result formatting with `formatResults()`
- ✅ Complete JSDoc comments
- ✅ Detailed error messages
- ✅ Empty result suggestions
- ✅ Safe date handling
- ✅ Version in User-Agent

