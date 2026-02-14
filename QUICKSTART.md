# Quick Start - claw-search

Get claw-search running in **5 minutes**!

## Prerequisites

- OpenClaw installed
- Docker installed (for SearXNG)

## One-Command Deploy

```bash
./deploy.sh
```

That's it! The script will:
1. ✅ Deploy SearXNG container (if not running)
2. ✅ Configure JSON API
3. ✅ Install claw-search plugin
4. ✅ Restart OpenClaw gateway

---

## Manual Installation

If you prefer step-by-step:

### 1. Deploy SearXNG

```bash
docker run -d \
  --name searxng \
  --restart=always \
  -p 8888:8080 \
  searxng/searxng:latest

# Wait 15 seconds for initialization
sleep 15

# Enable JSON API
docker exec searxng sed -i '/formats:/a\    - json' /etc/searxng/settings.yml
docker restart searxng
```

### 2. Install Plugin

```bash
openclaw plugins install .
```

### 3. Restart Gateway

```bash
openclaw gateway restart
```

---

## 5. Test It!

```bash
./test.sh
```

Or ask OpenClaw:
- "Search for quantum computing"
- "Find latest AI news"
- "Show me sunset pictures"
- "Find Python tutorial videos" (NEW!)
- "Search for React repositories" (NEW!)
- "What is TypeScript?" (NEW!)

**6 search tools at your service!** Done! 🎉

---

## Uninstall

```bash
./uninstall.sh
```

---

## Troubleshooting

### SearXNG not accessible

```bash
# Check if running
docker ps | grep searxng

# Check logs
docker logs searxng

# Restart
docker restart searxng
```

### Plugin not loading

```bash
# Check installation
openclaw plugins info claw-search

# Reinstall
rm -rf ~/.openclaw/extensions/claw-search
openclaw plugins install .
openclaw gateway restart
```

---

**Need help?** Open an issue on GitHub!
