# Changelog

All notable changes to claw-search will be documented in this file.

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

