# Beam Search Strategy

Advanced search strategy for complex reasoning with configurable beam width and depth.

## Overview

Beam Search explores multiple reasoning paths simultaneously, keeping only the top-k most promising paths at each step.

## Why Beam Search?

Traditional greedy search explores only the best path:
```
Input → Best Path → Conclusion
```

Beam Search explores multiple paths:
```
Input → Top 5 Paths → Expand → Top 5 Paths → Conclusion
```

## Configuration

```python
from judicial_reasoning_framework import BeamSearchStrategy

strategy = BeamSearchStrategy(
    beam_width=5,      # Keep top 5 paths
    max_depth=3        # Search up to 3 levels deep
)
```

### Parameters

- **beam_width**: Number of paths to keep at each step (default: 3)
- **max_depth**: Maximum search depth (default: 2)

## Usage

```python
from judicial_reasoning_framework import JudicialReasoningFramework, BeamSearchStrategy

jrf = JudicialReasoningFramework()

# Create beam search strategy
strategy = BeamSearchStrategy(beam_width=5, max_depth=3)

# Run protocol with beam search
verdict = jrf.run_protocol_with_strategy(
    "Complex medical case with multiple symptoms",
    strategy
)
```

## When to Use Beam Search

✅ **Use Beam Search when**:
- Input is complex with multiple interpretations
- High-stakes decisions requiring thorough exploration
- Uncertainty about best reasoning path

❌ **Skip Beam Search when**:
- Simple, straightforward input
- Time-sensitive decisions
- Clear single interpretation

## Performance

| Beam Width | Paths Explored | Time | Quality |
|------------|----------------|------|---------|
| 1 (greedy) | 1 | 1x | Baseline |
| 3 (default) | 3-9 | 2-3x | +15% |
| 5 | 5-25 | 3-5x | +25% |
| 10 | 10-100 | 5-10x | +30% |

## Example

```python
from judicial_reasoning_framework import JudicialReasoningFramework, BeamSearchStrategy

jrf = JudicialReasoningFramework()

# Complex case
complex_case = """
Patient: 62F
Symptoms: Chest pain, shortness of breath, dizziness, nausea
Duration: 2 hours
History: Hypertension, diabetes, smoking
Medications: Metformin, lisinopril
Vitals: BP 160/95, HR 110, SpO2 92%
"""

# Use beam search for thorough exploration
strategy = BeamSearchStrategy(beam_width=5, max_depth=3)
verdict = jrf.run_protocol_with_strategy(complex_case, strategy)

print(f"Certainty: {verdict.certainty:.0%}")
print(f"Paths explored: {verdict.metadata.paths_considered}")
```

## Best Practices

### 1. Start with Default

```python
# Default beam width (3) is good for most cases
strategy = BeamSearchStrategy()
```

### 2. Increase for Complex Cases

```python
# Complex case → wider beam
strategy = BeamSearchStrategy(beam_width=5, max_depth=3)
```

### 3. Monitor Performance

```python
import time

start = time.time()
verdict = jrf.run_protocol_with_strategy(input_text, strategy)
elapsed = time.time() - start

print(f"Time: {elapsed:.1f}s")
print(f"Certainty: {verdict.certainty:.0%}")
```

## Next Steps

- [Custom Strategies](custom-strategies.md) - Create your own search strategies
- [Python Bindings](python-bindings.md) - Use JRF from Python
- [Examples](../examples/medical-diagnosis.md) - See beam search in action
