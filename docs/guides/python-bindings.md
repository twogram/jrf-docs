# Python Bindings

JRF provides complete Python bindings via PyO3 for seamless integration.

## Installation

```bash
pip install judicial-reasoning-framework
```

## Basic Usage

```python
from judicial_reasoning_framework import JudicialReasoningFramework

jrf = JudicialReasoningFramework()
verdict = jrf.run_protocol("Input text")

print(verdict.conclusion)
```

## Architecture

```
Python Layer (PyO3)
    ↓
Rust Core (jrf-core)
    ↓
Protocol Execution
```

## API Overview

### Main Class

```python
from judicial_reasoning_framework import JudicialReasoningFramework

jrf = JudicialReasoningFramework(
    forensic_config=...,
    multipath_config=...,
    verdict_config=...
)
```

### Configuration Classes

```python
from judicial_reasoning_framework import (
    ForensicConfig,
    MultiPathConfig,
    VerdictConfig
)

forensic_config = ForensicConfig(min_facts=2)
multipath_config = MultiPathConfig(enable_all_paths=True)
verdict_config = VerdictConfig(min_certainty=0.5)
```

### Data Classes

```python
from judicial_reasoning_framework import Verdict, PathType

verdict = jrf.run_protocol(input_text)

# Access verdict properties
print(verdict.conclusion)          # str
print(verdict.certainty)           # float (0.0-1.0)
print(verdict.primary_path)        # PathType enum
print(verdict.recommendations)     # List[str]
```

## Type Hints

Full type hints for IDE support:

```python
from judicial_reasoning_framework import (
    JudicialReasoningFramework,
    Verdict,
    PathType,
    VerdictMetadata
)

def analyze_case(case: str) -> Verdict:
    jrf = JudicialReasoningFramework()
    return jrf.run_protocol(case)

verdict: Verdict = analyze_case("Patient has fever")
certainty: float = verdict.certainty
path: PathType = verdict.primary_path
```

## Error Handling

```python
from judicial_reasoning_framework import JRFError, VerdictError

try:
    verdict = jrf.run_protocol(input_text)
except VerdictError as e:
    print(f"Verdict error: {e}")
except JRFError as e:
    print(f"JRF error: {e}")
```

## Performance

Python bindings have minimal overhead:

| Operation | Rust (native) | Python (PyO3) | Overhead |
|-----------|---------------|---------------|----------|
| Protocol execution | 100ms | 105ms | +5% |
| Verdict synthesis | 50ms | 52ms | +4% |

## Best Practices

### 1. Reuse JRF Instance

```python
# ✅ Good: Reuse instance
jrf = JudicialReasoningFramework()
for case in cases:
    verdict = jrf.run_protocol(case)

# ❌ Bad: Create new instance each time
for case in cases:
    jrf = JudicialReasoningFramework()  # Slow!
    verdict = jrf.run_protocol(case)
```

### 2. Use Type Hints

```python
from judicial_reasoning_framework import Verdict

def process_verdict(verdict: Verdict) -> dict:
    return {
        "conclusion": verdict.conclusion,
        "certainty": verdict.certainty
    }
```

### 3. Handle Errors

```python
from judicial_reasoning_framework import JRFError

try:
    verdict = jrf.run_protocol(input_text)
except JRFError as e:
    # Handle error
    print(f"Error: {e}")
    verdict = None
```

## Next Steps

- [API Reference](../api/python-api.md) - Complete API documentation
- [Examples](../examples/medical-diagnosis.md) - See Python bindings in action
- [Rust Integration](rust-integration.md) - Use JRF from Rust
