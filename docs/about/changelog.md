# Changelog

All notable changes to JRF will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2024-02-01

### Added
- **Beam Search Strategy**: Configurable beam width and max depth for complex reasoning
- **Python Bindings**: Complete Python API via PyO3/Maturin
- **Multi-Platform Wheels**: Pre-built wheels for Linux, macOS, Windows (Python 3.8-3.12)
- **GitHub Actions CI/CD**: Automated testing and PyPI publication
- **Documentation Website**: MkDocs Material documentation site
- **Integration Guides**: Agent-Lightning and Microsoft Agent Framework

### Changed
- Improved certainty calculation with convergence bonus
- Enhanced moot court deliberation with severity-based critique filtering
- Optimized verdict synthesis with quality scoring

### Fixed
- Clippy warnings (unused imports, manual clamp patterns)
- Test coverage for all 5 protocol steps
- Memory safety in Rust core

## [0.1.0] - 2024-01-15

### Added
- **Core Protocol**: 5-step judicial reasoning framework
  - Forensic Deconstruction
  - Context Lock
  - Multi-Path Reasoning (Literal, Intentional, Procedural)
  - Moot Court (Adversarial deliberation)
  - Verdict Synthesis
- **Rust Implementation**: High-performance core in Rust
- **Domain Detection**: Automatic domain detection (medical, legal, financial, etc.)
- **Certainty Scoring**: Confidence scores for verdicts
- **Recommendations**: Actionable recommendations based on analysis
- **Comprehensive Tests**: 71 unit and integration tests

### Documentation
- README with quick start guide
- API documentation
- Example use cases (medical, legal, financial)

## [Unreleased]

### Planned
- **Phase 5: DIKWP Formalization**
  - Semantic graph representation
  - Explicit stakeholder modeling
  - Automatic conflict detection
- **Performance Optimizations**
  - Parallel path execution
  - Caching for repeated analyses
- **Additional Integrations**
  - LangChain support
  - LlamaIndex support
- **Enhanced Visualizations**
  - Reasoning path diagrams
  - Critique/defense visualization
  - Certainty evolution charts

---

## Version History

| Version | Release Date | Highlights |
|---------|--------------|------------|
| 0.2.0 | 2024-02-01 | Beam Search, Python bindings, PyPI publication |
| 0.1.0 | 2024-01-15 | Initial release with 5-step protocol |

---

## Migration Guides

### Upgrading from 0.1.0 to 0.2.0

**Python API Changes**:

```python
# Old (0.1.0)
from jrf import JRF
jrf = JRF()

# New (0.2.0)
from judicial_reasoning_framework import JudicialReasoningFramework
jrf = JudicialReasoningFramework()
```

**Beam Search**:

```python
# New in 0.2.0
from judicial_reasoning_framework import BeamSearchStrategy

strategy = BeamSearchStrategy(beam_width=5, max_depth=3)
verdict = jrf.run_protocol_with_strategy(input_text, strategy)
```

**Configuration**:

```python
# Old (0.1.0)
jrf = JRF(min_certainty=0.5)

# New (0.2.0)
from judicial_reasoning_framework import VerdictConfig

config = VerdictConfig(min_certainty=0.5)
jrf = JudicialReasoningFramework(verdict_config=config)
```

---

## Contributing

See [Contributing Guide](contributing.md) for how to contribute to JRF.

## Support

- **GitHub Issues**: https://github.com/twogram/jrf/issues
- **Discussions**: https://github.com/twogram/jrf/discussions
- **Documentation**: https://twogram.github.io/jrf-docs/
