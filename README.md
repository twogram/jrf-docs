# JRF Documentation

Official documentation for **Judicial Reasoning Framework (JRF)** - Universal multi-agent reasoning based on judicial logic.

## Quick Links

- **Documentation Site**: https://twogram.github.io/jrf-docs/
- **GitHub Repository**: https://github.com/twogram/jrf
- **PyPI Package**: https://pypi.org/project/judicial-reasoning-framework/

## Local Development

### Prerequisites

- Python 3.8+
- pip or uv

### Setup

```bash
# Clone repository
git clone https://github.com/twogram/jrf-docs.git
cd jrf-docs

# Install dependencies
pip install mkdocs-material pymdown-extensions

# Serve locally
mkdocs serve
```

Open http://127.0.0.1:8000 in your browser.

### Build

```bash
# Build static site
mkdocs build

# Output in site/ directory
```

## Structure

```
jrf-docs/
├── docs/
│   ├── index.md                    # Home page
│   ├── getting-started/            # Installation, quick start
│   ├── concepts/                   # Core concepts
│   ├── guides/                     # How-to guides
│   ├── integrations/               # Integration guides
│   ├── api/                        # API reference
│   ├── examples/                   # Examples
│   └── about/                      # Changelog, roadmap
├── mkdocs.yml                      # MkDocs configuration
└── .github/workflows/              # GitHub Actions
```

## Contributing

Contributions welcome! To contribute to documentation:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test locally with `mkdocs serve`
5. Submit a pull request

## Deployment

Documentation is automatically deployed to GitHub Pages on push to `main` branch via GitHub Actions.

## License

MIT License - see [LICENSE](https://github.com/twogram/jrf/blob/main/LICENSE)
