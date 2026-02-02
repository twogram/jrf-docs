# Quick Start

Get started with JRF in 5 minutes!

## Basic Usage

```python
from judicial_reasoning_framework import JudicialReasoningFramework

# Initialize
jrf = JudicialReasoningFramework()

# Run protocol
verdict = jrf.run_protocol("Patient has fever for 3 days")

# Print results
print(verdict.conclusion)
print(f"Certainty: {verdict.certainty:.0%}")
```

## Step-by-Step Example

### 1. Import and Initialize

```python
from judicial_reasoning_framework import JudicialReasoningFramework

jrf = JudicialReasoningFramework()
```

### 2. Prepare Input

```python
input_text = """
Patient: 45-year-old male
Symptoms: Persistent fever (38.5°C), dry cough, fatigue
Duration: 3 days
Medical history: No chronic conditions
"""
```

### 3. Run the Protocol

```python
verdict = jrf.run_protocol(input_text)
```

This executes all 5 steps:

1. **Forensic Deconstruction** - Extracts facts and context
2. **Context Lock** - Freezes interpretation
3. **Multi-Path Reasoning** - Generates 3 hypotheses
4. **Moot Court** - Adversarial deliberation
5. **Verdict Synthesis** - Final decision

### 4. Access Results

```python
# Main conclusion
print("Conclusion:", verdict.conclusion)

# Certainty score (0.0 - 1.0)
print(f"Certainty: {verdict.certainty:.0%}")

# Primary reasoning path
print("Primary path:", verdict.primary_path)

# Recommendations
for rec in verdict.recommendations:
    print(f"- {rec}")

# Full justification
print("\nJustification:")
print(verdict.justification)
```

## Output Example

```
Conclusion: Conclusion (intentional approach): L'objectif identifié 'diagnostic fever cause' dans le domaine medical est analysé à travers 3 chemin(x) validé(s), révélant une intention claire.

Certainty: 75%

Primary path: PathType.Intentional

Recommendations:
- Convergence de plusieurs chemins: Conclusion robuste

Justification:
Le chemin Intentional a été retenu comme chemin principal avec un score de solidité de 82%. 
Points forts: Clear medical context, Specific symptoms, Temporal information. 
L'analyse a identifié 4 fait(s) et 1 objectif(s). 
La délibération a considéré 3 chemin(x) et identifié 2 critique(s).
```

## Configuration

### Custom Configuration

```python
from judicial_reasoning_framework import (
    JudicialReasoningFramework,
    ForensicConfig,
    MultiPathConfig
)

# Configure forensic analysis
forensic_config = ForensicConfig(
    min_facts=2,
    enable_domain_detection=True
)

# Configure multi-path reasoning
multipath_config = MultiPathConfig(
    enable_all_paths=True,
    min_confidence=0.6
)

# Initialize with custom config
jrf = JudicialReasoningFramework(
    forensic_config=forensic_config,
    multipath_config=multipath_config
)
```

### Beam Search Strategy

For complex reasoning, use Beam Search:

```python
from judicial_reasoning_framework import BeamSearchStrategy

# Create beam search strategy
strategy = BeamSearchStrategy(
    beam_width=5,      # Explore top 5 paths
    max_depth=3        # Up to 3 levels deep
)

# Use with JRF
verdict = jrf.run_protocol_with_strategy(input_text, strategy)
```

## Next Steps

- [First Verdict](first-verdict.md) - Detailed walkthrough
- [Core Concepts](../concepts/overview.md) - Understand the protocol
- [Beam Search](../guides/beam-search.md) - Advanced reasoning
- [Examples](../examples/medical-diagnosis.md) - Real-world use cases
