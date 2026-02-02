# Contributing to JRF

Thank you for your interest in contributing to JRF!

## Ways to Contribute

### 1. Report Bugs

Found a bug? [Open an issue](https://github.com/twogram/jrf/issues/new?template=bug_report.md).

**Include**:
- JRF version
- Python/Rust version
- Operating system
- Minimal reproduction code
- Expected vs actual behavior

### 2. Suggest Features

Have an idea? [Open a feature request](https://github.com/twogram/jrf/issues/new?template=feature_request.md).

**Include**:
- Use case description
- Proposed solution
- Alternatives considered

### 3. Improve Documentation

Documentation improvements are always welcome!

**Areas**:
- Fix typos
- Add examples
- Clarify explanations
- Add diagrams

### 4. Submit Code

Want to contribute code? Great!

## Development Setup

### Prerequisites

- Rust 1.70+
- Python 3.8+
- Git

### Clone Repository

```bash
git clone https://github.com/twogram/jrf.git
cd jrf
```

### Python Development

```bash
cd jrf-python

# Install dependencies
pip install maturin pytest

# Build
maturin develop

# Test
pytest

# Format
black .
```

## Contribution Workflow

### 1. Fork Repository

Fork https://github.com/twogram/jrf

### 2. Create Branch

```bash
git checkout -b feature/my-feature
```

**Branch naming**:
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation
- `refactor/` - Code refactoring

### 3. Make Changes

Write code following our style guide.

### 4. Add Tests

```python
def test_my_feature():
    from judicial_reasoning_framework import JudicialReasoningFramework
    
    jrf = JudicialReasoningFramework()
    # Test code
    verdict = jrf.run_protocol("test case")
    assert verdict.certainty > 0.5
```

### 5. Run Tests

```bash
# Python tests
pytest

# With coverage
pytest --cov=judicial_reasoning_framework
```

### 6. Commit Changes

```bash
git add .
git commit -m "feat: Add my feature"
```

**Commit message format**:
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `refactor:` - Code refactoring
- `test:` - Add tests

### 7. Push Branch

```bash
git push origin feature/my-feature
```

### 8. Open Pull Request

Open PR on GitHub with:
- Clear description
- Link to related issue
- Screenshots (if UI changes)

## Code Style

### Python

Follow [PEP 8](https://pep8.org/).

```python
# ✅ Good
def analyze(self, input_text: str) -> Verdict:
    """Analyze input and return verdict."""
    return self.jrf.run_protocol(input_text)

# ❌ Bad
def analyze(self,input_text:str)->Verdict:
    return self.jrf.run_protocol(input_text)
```

## Testing Guidelines

### Unit Tests

Test individual functions:

```python
def test_forensic_analysis():
    from judicial_reasoning_framework import JudicialReasoningFramework
    
    jrf = JudicialReasoningFramework()
    verdict = jrf.run_protocol("test input")
    assert verdict is not None
```

### Integration Tests

Test full protocol:

```python
def test_full_protocol():
    jrf = JudicialReasoningFramework()
    verdict = jrf.run_protocol("Patient has fever")
    assert verdict.certainty > 0.5
```

## Documentation Guidelines

### Code Comments

Use clear, descriptive comments in your code:

```python
def analyze(input_text: str) -> Verdict:
    """
    Analyze input text and return verdict.
    
    Args:
        input_text: Raw input text to analyze
        
    Returns:
        Verdict containing conclusion, certainty, and recommendations
        
    Raises:
        ValueError: If input is too short or invalid
    """
    # Implementation
    pass
```

### Markdown Documentation

Use clear headings and examples:

```markdown
# Feature Name

Brief description.

## Usage

\`\`\`python
# Example code
\`\`\`

## Configuration

...
```

## Review Process

1. **Automated Checks**: CI runs tests and lints
2. **Code Review**: Maintainer reviews code
3. **Feedback**: Address review comments
4. **Approval**: Maintainer approves PR
5. **Merge**: PR merged to main

## Community Guidelines

- Be respectful and inclusive
- Provide constructive feedback
- Help others learn
- Follow [Code of Conduct](https://github.com/twogram/jrf/blob/main/CODE_OF_CONDUCT.md)

## Questions?

- **GitHub Discussions**: https://github.com/twogram/jrf/discussions
- **Issues**: https://github.com/twogram/jrf/issues

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

Thank you for contributing to JRF! 🎉
