# /// script
# requires-python = ">=3.10"
# dependencies = ["mcp>=1.0", "httpx>=0.27"]
# ///
"""
Web Logger MCP Server — Firecrawl-backed web access with audit log.

All requests logged to ~/.claude/web_access.log:
  TIMESTAMP | TOOL       | URL/QUERY | REASON

Tools:
  web_fetch(url, reason)    — scrape URL → clean markdown
  web_search(query, reason) — search web → top 5 results
"""

import os
from datetime import datetime, timezone
from pathlib import Path

import httpx
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("web-logger")

# ── config ────────────────────────────────────────────────────────────────────

LOG_FILE = Path.home() / ".claude" / "web_access.log"
SECRETS_FILE = Path.home() / ".claude" / "secrets.env"
FIRECRAWL_BASE = "https://api.firecrawl.dev/v1"


def _api_key() -> str:
    """Read FIRECRAWL_API_KEY from env or ~/.claude/secrets.env."""
    key = os.environ.get("FIRECRAWL_API_KEY")
    if key:
        return key
    if SECRETS_FILE.exists():
        for line in SECRETS_FILE.read_text().splitlines():
            line = line.strip()
            if line.startswith("FIRECRAWL_API_KEY="):
                return line.split("=", 1)[1].strip()
    raise RuntimeError(
        f"FIRECRAWL_API_KEY not set. Add it to {SECRETS_FILE} or env."
    )


def _log(tool: str, target: str, reason: str) -> None:
    ts = datetime.now(timezone.utc).isoformat(timespec="seconds")
    LOG_FILE.parent.mkdir(parents=True, exist_ok=True)
    with LOG_FILE.open("a") as f:
        f.write(f"{ts} | {tool:<12} | {target} | {reason!r}\n")


# ── tools ─────────────────────────────────────────────────────────────────────

@mcp.tool()
def web_fetch(url: str, reason: str) -> str:
    """
    Fetch a URL via Firecrawl and return clean markdown content.
    Always provide reason: why you need this page.
    """
    _log("web_fetch", url, reason)
    try:
        resp = httpx.post(
            f"{FIRECRAWL_BASE}/scrape",
            headers={"Authorization": f"Bearer {_api_key()}"},
            json={"url": url, "formats": ["markdown"]},
            timeout=30,
        )
        resp.raise_for_status()
        data = resp.json()
        content = data.get("data", {}).get("markdown", "")
        if not content:
            content = data.get("data", {}).get("content", "(no content)")
        # Truncate to 8KB
        if len(content) > 8192:
            content = content[:8192] + "\n\n[... truncated at 8KB ...]"
        return content
    except httpx.HTTPStatusError as e:
        return f"HTTP {e.response.status_code}: {e.response.text[:500]}"
    except Exception as e:
        return f"Error: {e}"


@mcp.tool()
def web_search(query: str, reason: str) -> str:
    """
    Search the web via Firecrawl and return top results.
    Always provide reason: what you're looking for.
    """
    _log("web_search", query, reason)
    try:
        resp = httpx.post(
            f"{FIRECRAWL_BASE}/search",
            headers={"Authorization": f"Bearer {_api_key()}"},
            json={"query": query, "limit": 5},
            timeout=30,
        )
        resp.raise_for_status()
        data = resp.json()
        results = data.get("data", [])
        if not results:
            return "(no results)"
        lines = []
        for i, r in enumerate(results[:5], 1):
            title = r.get("title", "Untitled")
            url = r.get("url", "")
            desc = r.get("description", r.get("markdown", ""))[:300]
            lines.append(f"{i}. **{title}**\n   {url}\n   {desc}")
        return "\n\n".join(lines)
    except httpx.HTTPStatusError as e:
        return f"HTTP {e.response.status_code}: {e.response.text[:500]}"
    except Exception as e:
        return f"Error: {e}"


if __name__ == "__main__":
    mcp.run()
