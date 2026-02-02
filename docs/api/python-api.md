# Python API Reference

Complete API reference for JRF Python bindings.

## JudicialReasoningFramework

Main class for running the judicial protocol.

```python
from judicial_reasoning_framework import JudicialReasoningFramework

jrf = JudicialReasoningFramework()
verdict = jrf.run_protocol("Input text")
```

### Constructor

```python
JudicialReasoningFramework(
    forensic_config: Optional[ForensicConfig] = None,
    context_config: Optional[ContextConfig] = None,
    multipath_config: Optional[MultiPathConfig] = None,
    mootcourt_config: Optional[MootCourtConfig] = None,
    verdict_config: Optional[VerdictConfig] = None,
    llm_backend: Optional[LLMBackend] = None
)
```

**Parameters**:
- `forensic_config`: Configuration for forensic deconstruction
- `context_config`: Configuration for context lock
- `multipath_config`: Configuration for multi-path reasoning
- `mootcourt_config`: Configuration for moot court
- `verdict_config`: Configuration for verdict synthesis
- `llm_backend`: Custom LLM backend (default: OpenAI GPT-4)

### Methods

#### run_protocol

```python
def run_protocol(self, input_text: str) -> Verdict:
    """Run the complete 5-step judicial protocol"""
```

**Parameters**:
- `input_text` (str): Raw input text to analyze

**Returns**:
- `Verdict`: Final verdict with conclusion, certainty, and justification

**Example**:
```python
verdict = jrf.run_protocol("Patient has fever for 3 days")
print(verdict.conclusion)
```

#### run_protocol_with_strategy

```python
def run_protocol_with_strategy(
    self,
    input_text: str,
    strategy: SearchStrategy
) -> Verdict:
    """Run protocol with custom search strategy"""
```

**Parameters**:
- `input_text` (str): Raw input text
- `strategy` (SearchStrategy): Custom search strategy (e.g., BeamSearch)

**Returns**:
- `Verdict`: Final verdict

**Example**:
```python
from judicial_reasoning_framework import BeamSearchStrategy

strategy = BeamSearchStrategy(beam_width=5, max_depth=3)
verdict = jrf.run_protocol_with_strategy(input_text, strategy)
```

---

## Configuration Classes

### ForensicConfig

Configuration for forensic deconstruction.

```python
from judicial_reasoning_framework import ForensicConfig

config = ForensicConfig(
    min_facts=2,
    enable_domain_detection=True,
    domain_hint="medical"
)
```

**Attributes**:
- `min_facts` (int): Minimum number of facts required (default: 1)
- `enable_domain_detection` (bool): Auto-detect domain (default: True)
- `domain_hint` (Optional[str]): Hint for domain detection

### MultiPathConfig

Configuration for multi-path reasoning.

```python
from judicial_reasoning_framework import MultiPathConfig

config = MultiPathConfig(
    enable_all_paths=True,
    min_confidence=0.6
)
```

**Attributes**:
- `enable_all_paths` (bool): Generate all 3 paths (default: True)
- `min_confidence` (float): Minimum confidence threshold (default: 0.5)

### VerdictConfig

Configuration for verdict synthesis.

```python
from judicial_reasoning_framework import VerdictConfig

config = VerdictConfig(
    min_certainty=0.5,
    min_validated_paths=1,
    enable_recommendations=True
)
```

**Attributes**:
- `min_certainty` (float): Minimum certainty required (default: 0.5)
- `min_validated_paths` (int): Minimum validated paths (default: 1)
- `enable_recommendations` (bool): Generate recommendations (default: True)

---

## Data Classes

### Verdict

Final verdict from the judicial protocol.

```python
class Verdict:
    conclusion: str
    justification: str
    certainty: float
    primary_path: PathType
    secondary_paths: List[PathType]
    recommendations: List[str]
    metadata: VerdictMetadata
```

**Attributes**:
- `conclusion` (str): Main conclusion
- `justification` (str): Detailed justification
- `certainty` (float): Certainty score (0.0 - 1.0)
- `primary_path` (PathType): Primary reasoning path
- `secondary_paths` (List[PathType]): Secondary paths considered
- `recommendations` (List[str]): Actionable recommendations
- `metadata` (VerdictMetadata): Metadata about the verdict

**Example**:
```python
verdict = jrf.run_protocol(input_text)

print(f"Conclusion: {verdict.conclusion}")
print(f"Certainty: {verdict.certainty:.0%}")
print(f"Primary path: {verdict.primary_path}")

for rec in verdict.recommendations:
    print(f"- {rec}")
```

### PathType

Enum for reasoning path types.

```python
from judicial_reasoning_framework import PathType

PathType.Literal       # Direct interpretation
PathType.Intentional   # Goal-oriented
PathType.Procedural    # Step-by-step
```

### VerdictMetadata

Metadata about the verdict.

```python
class VerdictMetadata:
    rendered_at: str
    paths_considered: int
    critiques_considered: int
    quality_score: float
```

**Attributes**:
- `rendered_at` (str): ISO 8601 timestamp
- `paths_considered` (int): Number of paths evaluated
- `critiques_considered` (int): Number of critiques raised
- `quality_score` (float): Overall quality score (0.0 - 1.0)

---

## Search Strategies

### BeamSearchStrategy

Beam search strategy for complex reasoning.

```python
from judicial_reasoning_framework import BeamSearchStrategy

strategy = BeamSearchStrategy(
    beam_width=5,
    max_depth=3
)

verdict = jrf.run_protocol_with_strategy(input_text, strategy)
```

**Parameters**:
- `beam_width` (int): Number of paths to explore (default: 3)
- `max_depth` (int): Maximum depth to search (default: 2)

---

## Exceptions

### JRFError

Base exception for all JRF errors.

```python
from judicial_reasoning_framework import JRFError

try:
    verdict = jrf.run_protocol(input_text)
except JRFError as e:
    print(f"JRF error: {e}")
```

### ForensicError

Errors during forensic deconstruction.

```python
from judicial_reasoning_framework import ForensicError

try:
    verdict = jrf.run_protocol("")
except ForensicError as e:
    print(f"Forensic error: {e}")
```

### VerdictError

Errors during verdict synthesis.

```python
from judicial_reasoning_framework import VerdictError

try:
    verdict = jrf.run_protocol(input_text)
except VerdictError as e:
    print(f"Verdict error: {e}")
```

---

## Complete Example

```python
from judicial_reasoning_framework import (
    JudicialReasoningFramework,
    ForensicConfig,
    MultiPathConfig,
    VerdictConfig,
    BeamSearchStrategy,
    PathType,
    JRFError
)

# Configure
forensic_config = ForensicConfig(
    min_facts=2,
    enable_domain_detection=True,
    domain_hint="medical"
)

multipath_config = MultiPathConfig(
    enable_all_paths=True,
    min_confidence=0.6
)

verdict_config = VerdictConfig(
    min_certainty=0.5,
    enable_recommendations=True
)

# Initialize
jrf = JudicialReasoningFramework(
    forensic_config=forensic_config,
    multipath_config=multipath_config,
    verdict_config=verdict_config
)

# Run with beam search
strategy = BeamSearchStrategy(beam_width=5, max_depth=3)

try:
    verdict = jrf.run_protocol_with_strategy(
        "Patient has fever for 3 days",
        strategy
    )
    
    print(f"Conclusion: {verdict.conclusion}")
    print(f"Certainty: {verdict.certainty:.0%}")
    print(f"Primary path: {verdict.primary_path}")
    
    if verdict.primary_path == PathType.Intentional:
        print("Goal-oriented reasoning selected")
    
    for rec in verdict.recommendations:
        print(f"- {rec}")
        
except JRFError as e:
    print(f"Error: {e}")
```

---

## Next Steps

- [Rust API Reference](rust-api.md)
- [Examples](../examples/medical-diagnosis.md)
- [Guides](../guides/beam-search.md)
