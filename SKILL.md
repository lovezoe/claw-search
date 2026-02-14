# claw-search Skill Documentation

**For OpenClaw Agent**

This plugin provides web search capabilities using a self-hosted SearXNG instance.

## Available Tools

The plugin registers **6 search tools** that are automatically available to the agent:

### 1. search

General web search across multiple search engines.

**Tool name:** `search`

**When to use:**
- User asks to search for something
- User wants to find information
- User needs web results
- General queries like "search for X", "find Y", "look up Z"

**Parameters:**
- `query` (string, required): Search query
- `count` (number, optional): Number of results (1-100, default: 10)

**Example queries:**
- "Search for quantum computing"
- "Find information about Docker"
- "Look up OpenClaw documentation"
- "What is SearXNG?"

**Returns:**
- Formatted list of search results
- Each result includes: title, URL, snippet
- Related search suggestions when available

**Response format:**
```
Found 10 results for "query":

1. **Result Title**
   https://example.com
   Snippet text describing the result...

2. **Another Result**
   https://example2.com
   More information about this result...

Related: related query, another query
```

---

### 2. search_news

Time-filtered news search.

**Tool name:** `search_news`

**When to use:**
- User asks for news
- User wants recent/latest information
- User mentions current events
- Queries like "news about X", "latest Y", "recent Z"

**Parameters:**
- `query` (string, required): News topic
- `count` (number, optional): Number of results (default: 10)
- `timeRange` (string, optional): Time filter
  - `pd` = past day (24 hours)
  - `pw` = past week (7 days) - **default**
  - `pm` = past month (30 days)
  - `py` = past year (365 days)

**Example queries:**
- "Find latest AI news"
- "What's the news about quantum computing?"
- "Recent breakthroughs in medicine"
- "Show me today's tech news"

**Returns:**
- News articles with publish dates
- Formatted with date indicators
- Titles, URLs, and snippets

**Response format:**
```
Found 5 news articles for "AI":

1. **AI Breakthrough Announced**
   https://news.example.com
   📅 2/14/2026
   Scientists achieve new milestone in AI research...

2. **New AI Regulations**
   https://news2.example.com
   📅 2/13/2026
   Government proposes framework...
```

---

### 3. search_images

Image search with URLs and metadata.

**Tool name:** `search_images`

**When to use:**
- User asks for images/pictures/photos
- User wants to find visual content
- Queries like "show me X", "find images of Y", "pictures of Z"

**Parameters:**
- `query` (string, required): Image search query
- `count` (number, optional): Number of images (default: 10)

**Example queries:**
- "Find sunset images"
- "Show me pictures of cats"
- "Search for OpenClaw logo"
- "Images of quantum computers"

**Returns:**
- Image URLs (full resolution)
- Thumbnail URLs
- Source URLs
- Titles

**Response format:**
```
Found 8 images for "sunset":

1. **Golden Sunset Over Ocean**
   🖼️  https://images.example.com/sunset1.jpg
   📐 Thumbnail: https://images.example.com/thumb1.jpg
   🌐 Source: https://example.com

2. **Mountain Sunset**
   🖼️  https://images.example.com/sunset2.jpg
   📐 Thumbnail: https://images.example.com/thumb2.jpg
   🌐 Source: https://example2.com
```

---

## Usage Guidelines

### How to Use in Conversations

**Example 1: General Search**

User: "Search for quantum computing"

Agent should:
1. Call `search` tool with `{ query: "quantum computing" }`
2. Present results clearly
3. Offer to dig deeper if needed

**Example 2: News Search**

User: "What's the latest AI news?"

Agent should:
1. Call `search_news` tool with `{ query: "AI" }`
2. Present news with dates
3. Summarize key points

**Example 3: Image Search**

User: "Find sunset pictures"

Agent should:
1. Call `search_images` tool with `{ query: "sunset" }`
2. Present image URLs
3. Offer to refine search

### Best Practices

**1. Format results nicely**
- Use numbered lists
- Include titles and URLs
- Show snippets when relevant
- Use emojis for visual clarity (🔍 📰 🖼️ 📅)

**2. Handle errors gracefully**
```
If search fails:
"I couldn't complete the search. The SearXNG instance might be unavailable. 
Please check if it's running at http://localhost:8888"
```

**3. Limit results by default**
- Show 5-10 results initially
- Offer to show more if user wants
- Don't overwhelm with too many results

**4. Understand context**
- "Latest" / "recent" → use `search_news`
- "Pictures" / "images" → use `search_images`
- General queries → use `search`

**5. Offer follow-up**
- "Would you like more results?"
- "Should I search for something more specific?"
- "Need details on any of these?"

### Response Examples

**Good response:**
```
I found several results about quantum computing:

1. **Quantum Computing Explained**
   https://example.com/quantum
   An introduction to quantum computing principles...

2. **Latest Advances**
   https://example.com/advances
   Recent breakthroughs in quantum technology...

Would you like more details on any of these, or should I search for something more specific?
```

**Not ideal:**
```
Here are the results: [raw data dump]
```

---

## Configuration

The plugin reads configuration from OpenClaw config:

```json
{
  "baseUrl": "http://localhost:8888",
  "maxResults": 10,
  "language": "en",
  "safesearch": 0,
  "timeout": 15
}
```

Configuration is managed by the user. As an agent, you just use the tools.

---

## Privacy Reminders

When discussing search with users:
- ✅ Emphasize it's their private SearXNG instance
- ✅ No tracking or logging
- ✅ All searches stay on their infrastructure
- ✅ Complete control and privacy

This is a privacy-focused tool. Respect that philosophy.

---

## Error Handling

If a search fails:
1. Don't expose technical details
2. Provide helpful guidance
3. Suggest checking SearXNG status

**Example:**
```
"I'm having trouble reaching the search service. 
Please check if SearXNG is running at http://localhost:8888"
```

Not:
```
"Error: ECONNREFUSED at fetch() line 42..."
```

---

## Tool Discovery

These tools are automatically registered when the plugin loads. 

OpenClaw makes them available based on:
- Plugin enabled status
- Agent tool allowlists (if configured)
- Tool execution policies

You don't need to manually enable them - just use them naturally based on user requests.

---

## Integration Notes

- **Installation:** Via `openclaw plugins install`
- **Configuration:** Via OpenClaw config file
- **Tool registration:** Automatic on plugin load
- **Availability:** Immediate after gateway restart

---

**Remember:** These tools empower privacy-conscious users. Present them as the private, self-hosted alternative they are meant to be.

Use them naturally, format results nicely, and help users get the information they need while respecting their privacy choices.

---

### 4. search_videos

Search for videos from YouTube, Vimeo, and other platforms.

**Tool name:** `search_videos`

**When to use:**
- User asks for videos
- User wants video tutorials or demonstrations
- Queries like "show me X video", "find Y tutorial", "watch Z"

**Parameters:**
- `query` (string, required): Video search query
- `count` (number, optional): Number of results (default: 10)

**Example queries:**
- "Find Python tutorial videos"
- "Show me quantum computing lectures"
- "Search for cooking videos"
- "TED talks about AI"

**Returns:**
- Video titles and URLs
- Thumbnails when available
- Publish dates when available
- Brief descriptions

**Response format:**
```
Found 5 videos for "Python tutorials":

1. **Python for Beginners - Full Course**
   🎬 https://youtube.com/watch?v=...
   📸 Thumbnail: https://...
   📅 1/15/2026
   Learn Python from scratch...

2. **Advanced Python Programming**
   🎬 https://youtube.com/watch?v=...
   Master Python with this comprehensive guide...
```

---

### 5. search_repos

Search for code repositories on GitHub, GitLab, and other platforms.

**Tool name:** `search_repos`

**When to use:**
- User asks for code, libraries, or repositories
- User wants to find open source projects
- Queries like "find X library", "search for Y project", "code for Z"

**Parameters:**
- `query` (string, required): Repository search query
- `count` (number, optional): Number of results (default: 10)

**Example queries:**
- "Find React repositories"
- "Search for Python machine learning projects"
- "Look up Docker alternatives"
- "Best Node.js frameworks"

**Returns:**
- Repository names and URLs
- Descriptions
- Related information (stars, language, etc. when available)

**Response format:**
```
Found 5 repositories for "React":

1. **facebook/react**
   💻 https://github.com/facebook/react
   A declarative, efficient, and flexible JavaScript library for building user interfaces...

2. **vercel/next.js**
   💻 https://github.com/vercel/next.js
   The React Framework for Production...
```

---

### 6. quick_answer

Get a direct answer to a factual question.

**Tool name:** `quick_answer`

**When to use:**
- User asks a factual question
- User wants a quick, direct answer
- Queries starting with "what is", "who is", "when did", "how many"

**Parameters:**
- `query` (string, required): Question to answer
- `count` (number, optional): Number of results (default: 10)

**Example queries:**
- "What is quantum computing?"
- "Who is the CEO of OpenAI?"
- "When was Python created?"
- "How many countries in the world?"

**Returns:**
- Direct answer when available (prioritized)
- Search results as fallback
- Source URLs

**Response format:**
```
💡 Direct answer: Quantum computing is a type of computation that harnesses quantum mechanical phenomena...

Found 5 results for "what is quantum computing":

1. Quantum Computing Explained
   https://example.com/quantum
   Quantum computing uses qubits instead of classical bits...

2. Introduction to Quantum Computing
   https://example.com/intro
   Learn the basics of quantum mechanics and computing...
```

**Best for:**
- Factual questions with clear answers
- Definitions and explanations
- Historical facts
- Statistical information

---

## Tool Selection Guidelines

Help the agent choose the right tool:

| Query Type | Best Tool |
|------------|-----------|
| General information | `search` |
| Current events, breaking news | `search_news` |
| Pictures, photos, diagrams | `search_images` |
| Tutorials, demonstrations, talks | `search_videos` |
| Code, libraries, frameworks | `search_repos` |
| Factual questions, definitions | `quick_answer` |

---

## Version History

- **v1.1.0**: Added `search_videos`, `search_repos`, `quick_answer`
- **v1.0.2**: Migrated to TypeScript
- **v1.0.1**: Fixed news search time_range issue
- **v1.0.0**: Initial release with `search`, `search_news`, `search_images`

---

**Remember:** All 6 tools use your private SearXNG instance. Emphasize privacy and self-hosting when appropriate.
