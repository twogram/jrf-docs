# Your First Verdict

This tutorial walks you through creating your first JRF verdict step-by-step.

## Scenario

You're building a medical diagnosis support system. A doctor inputs patient symptoms, and you need to provide a rigorous analysis with full justification.

## Step 1: Setup

```python
from judicial_reasoning_framework import JudicialReasoningFramework

# Initialize JRF
jrf = JudicialReasoningFramework()
```

## Step 2: Prepare Input

```python
patient_case = """
Patient ID: P-2024-001
Age: 45 years
Gender: Male

Chief Complaint:
- Persistent fever (38.5°C / 101.3°F)
- Dry cough
- Extreme fatigue
- Shortness of breath

Duration: 3 days

Medical History:
- No chronic conditions
- No known allergies
- Non-smoker

Recent Travel: None
Exposure: Possible exposure to sick colleague 5 days ago
"""
```

## Step 3: Run the Protocol

```python
verdict = jrf.run_protocol(patient_case)
```

Behind the scenes, JRF executes 5 steps:

### 3.1 Forensic Deconstruction

Extracts structured information:

- **Facts**: Fever 38.5°C, dry cough, fatigue, shortness of breath, 3 days duration
- **Desires**: Diagnose cause of symptoms
- **Context**: Medical domain, adult male patient
- **Detected Domain**: Medical

### 3.2 Context Lock

Freezes interpretation:

- **Domain**: Medical
- **Phase**: Forensic analysis
- **Locked Context**: Medical diagnostic reasoning

### 3.3 Multi-Path Reasoning

Generates 3 parallel hypotheses:

**Path 1: Literal** (Direct symptom analysis)
- Fever + respiratory symptoms → Respiratory infection

**Path 2: Intentional** (Goal-oriented)
- Goal: Identify underlying cause
- Hypothesis: Viral respiratory infection (COVID-19, flu, RSV)

**Path 3: Procedural** (Step-by-step)
- Step 1: Assess vital signs
- Step 2: Rule out emergency conditions
- Step 3: Consider differential diagnosis

### 3.4 Moot Court

Adversarial deliberation:

**Critique**: "Insufficient data for specific diagnosis"
**Defense**: "Symptom pattern consistent with viral infection"

**Validation Result**:
- Path 1 (Literal): Validated ✅
- Path 2 (Intentional): Validated ✅
- Path 3 (Procedural): Validated ✅

### 3.5 Verdict Synthesis

Final decision with justification.

## Step 4: Access Results

```python
# Main conclusion
print("=" * 60)
print("VERDICT")
print("=" * 60)
print(verdict.conclusion)
print()

# Certainty
print(f"Certainty: {verdict.certainty:.0%}")
print()

# Primary reasoning path
print(f"Primary Path: {verdict.primary_path}")
print()

# Justification
print("Justification:")
print(verdict.justification)
print()

# Recommendations
print("Recommendations:")
for i, rec in enumerate(verdict.recommendations, 1):
    print(f"{i}. {rec}")
```

## Expected Output

```
============================================================
VERDICT
============================================================
Conclusion (intentional approach): L'objectif identifié 'diagnose fever cause' 
dans le domaine medical est analysé à travers 3 chemin(x) validé(s), 
révélant une intention claire.

Certainty: 82%

Primary Path: PathType.Intentional

Justification:
Le chemin Intentional a été retenu comme chemin principal avec un score de 
solidité de 82%. Points forts: Clear medical context, Specific symptoms, 
Temporal information, Exposure history. L'analyse a identifié 5 fait(s) et 
1 objectif(s). La délibération a considéré 3 chemin(x) et identifié 2 critique(s).

Recommendations:
1. Convergence de plusieurs chemins: Conclusion robuste
2. Niveau de certitude élevé: Diagnostic fiable
```

## Step 5: Inspect Metadata

```python
# Metadata
metadata = verdict.metadata
print(f"Rendered at: {metadata.rendered_at}")
print(f"Paths considered: {metadata.paths_considered}")
print(f"Critiques considered: {metadata.critiques_considered}")
print(f"Quality score: {metadata.quality_score:.0%}")
```

Output:
```
Rendered at: 2024-02-01T22:45:00Z
Paths considered: 3
Critiques considered: 2
Quality score: 85%
```

## Complete Code

```python
from judicial_reasoning_framework import JudicialReasoningFramework

# Initialize
jrf = JudicialReasoningFramework()

# Input
patient_case = """
Patient ID: P-2024-001
Age: 45 years
Gender: Male

Chief Complaint:
- Persistent fever (38.5°C)
- Dry cough
- Extreme fatigue
- Shortness of breath

Duration: 3 days

Medical History: No chronic conditions
Exposure: Possible exposure to sick colleague 5 days ago
"""

# Run protocol
verdict = jrf.run_protocol(patient_case)

# Display results
print("VERDICT")
print("=" * 60)
print(verdict.conclusion)
print(f"\nCertainty: {verdict.certainty:.0%}")
print(f"Primary Path: {verdict.primary_path}")
print(f"\nJustification:\n{verdict.justification}")
print(f"\nRecommendations:")
for i, rec in enumerate(verdict.recommendations, 1):
    print(f"{i}. {rec}")
```

## Next Steps

Now that you've created your first verdict:

- **[Core Concepts](../concepts/overview.md)** - Understand the 5-step protocol in depth
- **[Beam Search](../guides/beam-search.md)** - Use advanced search strategies
- **[Examples](../examples/medical-diagnosis.md)** - See more real-world use cases
- **[API Reference](../api/python-api.md)** - Explore the full API

## Troubleshooting

### Low Certainty Score

If `verdict.certainty < 0.5`:

1. Provide more context in input
2. Be more specific about facts
3. Include relevant background information

### Unexpected Primary Path

If the primary path doesn't match expectations:

1. Review `verdict.justification` for reasoning
2. Check `verdict.secondary_paths` for alternatives
3. Adjust input to emphasize desired aspect

### No Recommendations

If `verdict.recommendations` is empty:

1. Enable recommendations in config:
   ```python
   from judicial_reasoning_framework import VerdictConfig
   
   config = VerdictConfig(enable_recommendations=True)
   jrf = JudicialReasoningFramework(verdict_config=config)
   ```
