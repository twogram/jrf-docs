# Installation

## Requirements

- **Python**: 3.8 or higher
- **Rust**: 1.70+ (only if building from source)

## Install from PyPI

The easiest way to install JRF is via pip:

```bash
pip install judicial-reasoning-framework
```

Or using uv:

```bash
uv pip install judicial-reasoning-framework
```

## Verify Installation

```python
import judicial_reasoning_framework as jrf

print(f"JRF version: {jrf.__version__}")
```

Expected output:
```
JRF version: 0.1.0
```

## Install from Source

For development or to get the latest features:

```bash
# Clone repository
git clone https://github.com/twogram/jrf.git
cd jrf

# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Build and install Python package
cd jrf-python
pip install maturin
maturin develop --release
```

## Platform Support

JRF provides pre-built wheels for:

- **Linux**: x86_64, aarch64
- **macOS**: x86_64, Apple Silicon (M1/M2)
- **Windows**: x86_64

Python versions: 3.8, 3.9, 3.10, 3.11, 3.12

## Dependencies

JRF automatically installs the following dependencies:

- `openai` - OpenAI API client
- `anthropic` - Anthropic API client
- `pydantic` - Data validation

## Optional Dependencies

For development:

```bash
pip install judicial-reasoning-framework[dev]
```

Includes:
- `pytest` - Testing framework
- `black` - Code formatting
- `mypy` - Type checking

## Troubleshooting

### Import Error

If you get `ModuleNotFoundError: No module named 'judicial_reasoning_framework'`:

1. Verify installation: `pip list | grep judicial`
2. Check Python version: `python --version`
3. Reinstall: `pip install --force-reinstall judicial-reasoning-framework`

### Build Errors (from source)

If building from source fails:

1. Update Rust: `rustup update`
2. Update maturin: `pip install --upgrade maturin`
3. Check Rust version: `rustc --version` (should be 1.70+)

## Next Steps

- [Quick Start](quick-start.md) - Run your first verdict
- [First Verdict](first-verdict.md) - Detailed walkthrough
- [Core Concepts](../concepts/overview.md) - Understand the protocol
