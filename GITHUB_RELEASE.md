# v1.1.0 - Extensible Architecture

Self-hosted private web search for OpenClaw using SearXNG. **Zero tracking, zero API costs, 100% private.**

---

## 🎉 What's New

### 3 New Search Tools

- **🎬 Video Search** - Search YouTube, Vimeo, and other video platforms
- **💻 Repository Search** - Find code on GitHub, GitLab, and more
- **💡 Quick Answer** - Get direct answers to factual questions

Now **6 search tools total!**

---

## 🏗️ Major Refactoring

Complete architecture overhaul for extensibility and maintainability:

**Before:**
- 3 tools with ~80% duplicated code
- Adding new tool = 60-70 lines of copy-paste

**After:**
- 6 tools with 0% duplication
- Adding new tool = 5-10 lines of config
- Generic `performSearch()` + factory pattern

**Impact:**
- ✅ Doubled features (+100%)
- ✅ Only 47% more code
- ✅ 86% reduction in code per tool
- ✅ Eliminated all duplication

---

## 📊 By The Numbers

| Metric | v1.0.x | v1.1.0 | Change |
|--------|--------|--------|--------|
| **Tools** | 3 | 6 | +100% 🎉 |
| **Code Lines** | 269 | 396 | +47% |
| **Code per Tool** | ~70 | ~10 | -86% ✅ |
| **Duplication** | ~80% | 0% | -100% ✅ |

---

## ✨ Features

### All 6 Search Tools

1. **🔍 General Search** - Web results from multiple engines
2. **📰 News Search** - Latest news articles
3. **🖼️ Image Search** - Images with metadata
4. **🎬 Video Search** - Videos from YouTube, Vimeo (NEW!)
5. **💻 Repository Search** - Code from GitHub, GitLab (NEW!)
6. **💡 Quick Answer** - Direct factual answers (NEW!)

### Core Benefits

- 🔒 **100% Private** - Your SearXNG, your data
- 💰 **Zero Cost** - No API fees, no rate limits
- ⚡ **Fast** - Self-hosted or localhost
- 🎯 **Native** - Seamless OpenClaw integration
- 🏗️ **Extensible** - Easy to add new search types

---

## 🚀 Quick Install

### One-Command Deploy

```bash
git clone https://github.com/binglius/claw-search.git
cd claw-search
./deploy.sh
```

The script automatically:
- ✅ Deploys SearXNG if not running
- ✅ Configures JSON API
- ✅ Installs the plugin
- ✅ Restarts gateway

### Manual Install

```bash
openclaw plugins install https://github.com/binglius/claw-search.git
```

*(Requires SearXNG running - see [QUICKSTART.md](QUICKSTART.md))*

---

## 🎯 Usage

Just ask naturally:
- "Search for Python tutorials"
- "Find latest AI news"
- "Show me sunset pictures"
- "Find React tutorial videos" **(NEW!)**
- "Search for TypeScript repositories" **(NEW!)**
- "What is quantum computing?" **(NEW!)**

OpenClaw automatically uses the right tool!

---

## 🛠️ Requirements

- OpenClaw installed
- Docker (for SearXNG)
- Node.js 18+ (usually already installed with OpenClaw)

---

## 📈 Quality Improvements

### Code Quality
- ✅ Input validation
- ✅ Detailed error messages
- ✅ Empty result suggestions
- ✅ Safe date handling
- ✅ Complete JSDoc comments
- ✅ Type-safe TypeScript

### Deployment
- ✅ Automated setup script
- ✅ Comprehensive test suite (8 tests)
- ✅ Uninstall script
- ✅ Complete documentation

---

## 🔄 Changes

### Added
- `search_videos` tool for video search
- `search_repos` tool for code repository search
- `quick_answer` tool for factual answers
- `deploy.sh` for automated deployment
- `uninstall.sh` for clean removal
- Input validation with `validateQuery()`
- URL building with `buildSearchUrl()`
- Result formatting with `formatResults()`

### Changed
- Complete refactoring to factory pattern
- Improved error handling
- Better empty result messages
- Enhanced documentation

### Removed
- `timeRange` parameter (not supported by most SearXNG engines)

---

## 🧪 Testing

All 8 tests passing:
```
✅ SearXNG Availability
✅ General Search
✅ News Search
✅ Image Search
✅ Video Search (NEW)
✅ Repository Search (NEW)
✅ Quick Answer (NEW)
✅ Plugin Installation
```

Run tests: `./test.sh`

---

## 📚 Documentation

- [README.md](README.md) - Complete documentation
- [QUICKSTART.md](QUICKSTART.md) - Get started in 5 minutes
- [SKILL.md](SKILL.md) - AI agent documentation
- [CHANGELOG.md](CHANGELOG.md) - Full version history

---

## 🙏 Credits

- Built for [OpenClaw](https://openclaw.ai/) users who value privacy
- Powered by [SearXNG](https://docs.searxng.org/) meta-search engine
- Inspired by the need for self-hosted search

---

## 📄 License

MIT License - Free for personal and commercial use

---

## 🐛 Report Issues

Found a bug? [Open an issue](https://github.com/binglius/claw-search/issues)

---

## 🚀 What's Next?

The extensible architecture makes it easy to add more search types:
- Music search
- Map search
- Shopping search
- Academic papers
- Social media

Each requires only 5-10 lines of configuration!

---

**Full Changelog**: [CHANGELOG.md](CHANGELOG.md#110---2026-02-14)

---

**claw-search v1.1.0** - Own your search. Own your data. 🦞🔍

*Because your searches are nobody's business but yours.*
