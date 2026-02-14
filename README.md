# claw-search 🦞🔍

**Self-hosted private web search for OpenClaw**

[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](CHANGELOG.md)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![TypeScript](https://img.shields.io/badge/TypeScript-Ready-blue.svg)]()
[![Tools](https://img.shields.io/badge/tools-6-brightgreen.svg)]()

A complete OpenClaw plugin that provides web search using your own SearXNG instance. Zero tracking, zero API costs, 100% private.

> **Latest:** v1.1.0 major refactoring - extensible architecture + 3 new search tools! See [CHANGELOG](CHANGELOG.md).

## ✨ Features

### Search Tools (6 Total)
- 🔍 **General search** - Web results from multiple search engines
- 📰 **News search** - Time-filtered news articles
- 🖼️ **Image search** - Find images with metadata
- 🎬 **Video search** - Search YouTube, Vimeo, and more (NEW!)
- 💻 **Repository search** - Find code on GitHub, GitLab (NEW!)
- 💡 **Quick answer** - Get direct answers to questions (NEW!)

### Core Benefits
- 🔒 **100% Private** - Your SearXNG, your data
- 💰 **Zero cost** - No API fees
- ⚡ **Fast** - Localhost or self-hosted
- 🎯 **Native integration** - Works seamlessly with OpenClaw
- 🏗️ **Extensible** - Easy to add new search types

## Requirements

Before installing claw-search, you need:

1. **OpenClaw** installed and running
2. **SearXNG instance** running (provided setup script)
3. **Docker** (for SearXNG)

### Quick Setup (Recommended)

Use the provided deployment script:

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


## Installation

### Quick Install

```bash
openclaw plugins install https://github.com/binglius/claw-search.git
```

### From Local Directory

```bash
git clone https://github.com/binglius/claw-search.git ~/claw-search
openclaw plugins install ~/claw-search
```

### Enable Plugin

```bash
openclaw plugins enable claw-search
openclaw gateway restart
```

## Configuration

The plugin works out-of-the-box with default settings. To customize, edit your OpenClaw config:

```json
{
  "plugins": {
    "entries": {
      "claw-search": {
        "enabled": true,
        "config": {
          "baseUrl": "http://localhost:8888",
          "maxResults": 10,
          "language": "en",
          "safesearch": 0,
          "timeout": 15
        }
      }
    }
  }
}
```

### Config Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `baseUrl` | string | `http://localhost:8888` | Your SearXNG instance URL |
| `maxResults` | number | `10` | Maximum results per search (1-100) |
| `language` | string | `en` | ISO 639-1 language code (en, zh, de, etc.) |
| `safesearch` | number | `0` | Safe search: 0=off, 1=moderate, 2=strict |
| `timeout` | number | `15` | Request timeout in seconds (5-60) |

## Usage

Once installed, just ask OpenClaw naturally:

- **"Search for quantum computing"** (uses `search`)
- **"Find recent AI news"** (uses `search_news`)
- **"Show me sunset pictures"** (uses `search_images`)
- **"Find Python tutorial videos"** (uses `search_videos`)
- **"Search for React repositories"** (uses `search_repos`)
- **"What is quantum computing?"** (uses `quick_answer`)

OpenClaw will automatically use the appropriate search tool!

## Tools Provided

The plugin registers **6 search tools**:

### 1. `search` 🔍
General web search across multiple engines.

**Example queries:**
- "Search for OpenClaw documentation"
- "Find information about SearXNG"
- "Look up Python tutorials"

### 2. `search_news` 📰
Time-filtered news search.

**Example queries:**
- "Find latest AI news"
- "What's happening in quantum computing?"
- "Recent breakthroughs in medicine"


### 3. `search_images` 🖼️
Image search with URLs and metadata.

**Example queries:**
- "Find sunset images"
- "Show me cat pictures"
- "Search for OpenClaw logo"

### 4. `search_videos` 🎬 NEW!
Search for videos from YouTube, Vimeo, and other platforms.

**Example queries:**
- "Find Python tutorial videos"
- "Search for quantum computing lectures"
- "Show me cooking videos"

### 5. `search_repos` 💻 NEW!
Search code repositories on GitHub, GitLab, and other platforms.

**Example queries:**
- "Find React repositories"
- "Search for Python machine learning projects"
- "Look up Docker alternatives"

### 6. `quick_answer` 💡 NEW!
Get direct answers to factual questions.

**Example queries:**
- "What is quantum computing?"

### 3. `search_images`
Image search with URLs and metadata.

**Example queries:**
- "Find sunset images"
- "Show me cat pictures"
- "Search for OpenClaw logo"


## 🏗️ Architecture

### v1.1.0 - Extensible Design

The plugin uses a **declarative configuration approach** for maximum extensibility:

```typescript
// Core: Generic search function (DRY principle)
async function performSearch(params) { ... }

// Factory: Create tools from config
function createSearchTool(config) { ... }

// Configuration: Easy to extend!
const searchTools = [
  { name: 'search', category: 'general', formatResult: ... },
  { name: 'search_news', category: 'news', formatResult: ... },
  // Add new search type = just 5-10 lines!
];
```

### Benefits

- **Zero duplication** - All tools share the same search logic
- **Easy to extend** - New search types require only configuration
- **Consistent behavior** - All tools follow the same pattern
- **Easy to maintain** - Fix once, apply everywhere

### Adding New Search Types

Want to add music search? Just add a configuration object:

```typescript
{
  name: 'search_music',
  description: 'Search for music tracks and albums',
  category: 'music',
  formatResult: (result, idx) => `${idx + 1}. 🎵 ${result.title}\n...`
}
```

That's it! No need to copy-paste 60-70 lines of code.

## Requirements

### Must Have

1. **SearXNG instance** running (Docker or native)
2. **JSON API enabled** in SearXNG
3. **OpenClaw >= 2026.2.0**

### SearXNG Quick Setup

Don't have SearXNG? Here's a 2-minute setup:

```bash
# 1. Run SearXNG in Docker
docker run -d \
  --name searxng \
  --restart=always \
  -p 8888:8080 \
  searxng/searxng:latest

# 2. Enable JSON API
docker exec searxng sed -i '/formats:/,/- html/{s/- html/- html\n    - json/}' /etc/searxng/settings.yml
docker restart searxng

# 3. Test it
curl "http://localhost:8888/search?q=test&format=json" | jq
```

Done! 🎉

## Verification

### Check Plugin Status

```bash
# List all plugins
openclaw plugins list

# Check claw-search details
openclaw plugins info claw-search
```

Expected output:
```
claw-search
Self-hosted private web search using SearXNG

Status: loaded
Tools: search, search_news, search_images
Version: 1.0.0
```

### Test Search

Ask OpenClaw:
```
"Search for OpenClaw"
```

You should see formatted search results!

## Troubleshooting

### Plugin Not Loading

**Check installation:**
```bash
openclaw plugins list | grep claw-search
```

**Check for errors:**
```bash
openclaw plugins doctor
```

**Reinstall:**
```bash
openclaw plugins uninstall claw-search
openclaw plugins install ~/claw-search
openclaw gateway restart
```

### Search Fails

**1. Check SearXNG is running:**
```bash
curl http://localhost:8888
```

**2. Check JSON API:**
```bash
curl "http://localhost:8888/search?q=test&format=json" | jq
```

**3. Check baseUrl in config:**
```bash
openclaw config get plugins.entries.claw-search.config.baseUrl
```

**4. Check logs:**
```bash
openclaw logs | grep claw-search
```

### Connection Timeout

- Increase `timeout` in plugin config
- Check network connectivity to SearXNG
- Verify `baseUrl` is correct and accessible

### Empty Results

- Confirm SearXNG has search engines enabled
- Test URL directly in browser: `http://localhost:8888/search?q=test`
- Check SearXNG configuration and logs

## Privacy & Security

✅ **Self-hosted** - All queries to your SearXNG instance  
✅ **No tracking** - Zero telemetry  
✅ **No third-party APIs** - Complete independence  
✅ **No API keys** - Nothing to leak  
✅ **Full control** - Your infrastructure, your rules  

## Comparison

| Feature | claw-search | Brave API | Google API |
|---------|-------------|-----------|------------|
| Privacy | ✅ 100% | ⚠️ Third-party | ❌ Tracked |
| Cost | ✅ Free | ❌ $5/month | ❌ Pay per use |
| Rate Limits | ✅ None | ❌ 2000/month | ❌ Limited |
| Self-hosted | ✅ Yes | ❌ No | ❌ No |
| Setup | ⚡ 5 min | 📝 Register | 📝 Register |

## Updates

### Update Plugin

```bash
cd ~/claw-search
git pull
openclaw plugins install .
openclaw gateway restart
```

### Update SearXNG

```bash
docker pull searxng/searxng:latest
docker stop searxng
docker rm searxng
# Re-run docker run command from setup
```

## Uninstall

```bash
openclaw plugins uninstall claw-search
openclaw gateway restart
```

## Project Structure

```
claw-search/
├── package.json            # NPM manifest
├── openclaw.plugin.json    # Plugin manifest with config schema
├── index.js                # Plugin implementation (3 tools)
├── SKILL.md                # Agent documentation
├── README.md               # This file
├── QUICKSTART.md           # Quick start guide
├── LICENSE                 # MIT License
└── .gitignore              # Git ignore rules
```

## Development

### Local Testing

```bash
# Install from local directory
openclaw plugins install ~/claw-search

# Check it loaded
openclaw plugins list | grep claw-search

# View tools
openclaw plugins info claw-search

# Test with OpenClaw
# Just ask to search for something!
```

### Plugin Architecture

The plugin exports a default function that receives the OpenClaw API:

```javascript
export default function (api) {
  // Register tools
  api.registerTool({
    name: 'search',
    description: '...',
    parameters: { /* JSON Schema */ },
    async execute(_id, params) {
      // Tool implementation
      return { content: [{ type: 'text', text: '...' }] };
    }
  });
}
```

Tools are automatically discovered and made available to the agent.

## Contributing

Contributions welcome! 

- **Issues:** Report bugs or request features
- **Pull Requests:** Improvements and fixes
- **Feedback:** Share your experience

## License

MIT - See [LICENSE](LICENSE)

## Credits

- Built for [OpenClaw](https://openclaw.ai/) users who value privacy
- Powered by [SearXNG](https://docs.searxng.org/)
- Inspired by the need for self-hosted search

## Support

- **Documentation:** [SKILL.md](SKILL.md), [QUICKSTART.md](QUICKSTART.md)
- **Issues:** https://github.com/binglius/claw-search/issues
- **OpenClaw Docs:** https://docs.openclaw.ai/

---

**claw-search** - Own your search. Own your data. 🦞🔍

*Because your searches are nobody's business but yours.*
