# Medical Diagnosis Example

This example demonstrates using JRF for medical diagnosis support.

## Scenario

A 45-year-old male patient presents with respiratory symptoms. We'll use JRF to analyze the case and provide a diagnostic verdict.

## Complete Code

```python
from judicial_reasoning_framework import JudicialReasoningFramework

# Initialize JRF
jrf = JudicialReasoningFramework()

# Patient case
patient_case = """
PATIENT INFORMATION
-------------------
ID: P-2024-001
Age: 45 years
Gender: Male
Weight: 82 kg
Height: 178 cm

CHIEF COMPLAINT
---------------
- Persistent fever (38.5°C / 101.3°F)
- Dry cough
- Extreme fatigue
- Shortness of breath on exertion

HISTORY OF PRESENT ILLNESS
---------------------------
Duration: 3 days
Onset: Gradual
Progression: Worsening

MEDICAL HISTORY
---------------
- No chronic conditions
- No known allergies
- Non-smoker
- Occasional alcohol use

RECENT HISTORY
--------------
- No recent travel
- Possible exposure to sick colleague 5 days ago
- No recent medication changes

VITAL SIGNS
-----------
- Temperature: 38.5°C
- Heart Rate: 92 bpm
- Blood Pressure: 128/82 mmHg
- Respiratory Rate: 22 breaths/min
- SpO2: 94% on room air
"""

# Run JRF protocol
print("Running JRF Medical Diagnosis Protocol...")
print("=" * 60)

verdict = jrf.run_protocol(patient_case)

# Display results
print("\nVERDICT")
print("=" * 60)
print(verdict.conclusion)
print()

print(f"Certainty: {verdict.certainty:.0%}")
print(f"Primary Reasoning Path: {verdict.primary_path}")
print()

print("JUSTIFICATION")
print("-" * 60)
print(verdict.justification)
print()

print("RECOMMENDATIONS")
print("-" * 60)
for i, rec in enumerate(verdict.recommendations, 1):
    print(f"{i}. {rec}")
print()

print("METADATA")
print("-" * 60)
print(f"Rendered at: {verdict.metadata.rendered_at}")
print(f"Paths considered: {verdict.metadata.paths_considered}")
print(f"Critiques considered: {verdict.metadata.critiques_considered}")
print(f"Quality score: {verdict.metadata.quality_score:.0%}")
```

## Expected Output

```
Running JRF Medical Diagnosis Protocol...
============================================================

VERDICT
============================================================
Conclusion (intentional approach): L'objectif identifié 'diagnose respiratory infection' 
dans le domaine medical est analysé à travers 3 chemin(x) validé(s), 
révélant une intention claire.

Certainty: 82%
Primary Reasoning Path: PathType.Intentional

JUSTIFICATION
------------------------------------------------------------
Le chemin Intentional a été retenu comme chemin principal avec un score de 
solidité de 82%. Points forts: Clear medical context, Specific vital signs, 
Temporal progression, Exposure history documented. L'analyse a identifié 
7 fait(s) et 1 objectif(s). La délibération a considéré 3 chemin(x) et 
identifié 2 critique(s).

RECOMMENDATIONS
------------------------------------------------------------
1. Convergence de plusieurs chemins: Conclusion robuste
2. Niveau de certitude élevé: Diagnostic fiable
3. Considérer tests complémentaires: PCR, radiographie thoracique

METADATA
------------------------------------------------------------
Rendered at: 2024-02-01T23:15:00Z
Paths considered: 3
Critiques considered: 2
Quality score: 85%
```

## Analysis Breakdown

### 1. Forensic Deconstruction

**Facts Extracted**:
- Fever 38.5°C
- Dry cough
- Fatigue
- Shortness of breath
- SpO2 94%
- Duration 3 days
- Possible exposure 5 days ago

**Desires Identified**:
- Diagnose cause of respiratory symptoms

**Context Detected**:
- Domain: Medical
- Specialty: Respiratory medicine
- Urgency: Moderate

### 2. Multi-Path Reasoning

**Literal Path**: Direct symptom analysis
- Fever + cough + SOB = Respiratory infection
- Vital signs stable
- No emergency indicators

**Intentional Path**: Goal-oriented diagnosis
- Goal: Identify specific pathogen
- Differential: COVID-19, Influenza, RSV, Bacterial pneumonia
- Exposure history supports viral etiology

**Procedural Path**: Step-by-step workup
1. Assess severity (moderate)
2. Rule out emergency (stable vitals)
3. Consider differential diagnosis
4. Recommend diagnostic tests

### 3. Moot Court Deliberation

**Critique 1**: "Insufficient data for specific pathogen identification"
- **Severity**: 0.6
- **Defense**: "Symptom pattern + exposure history suggest viral infection"
- **Result**: Path validated with recommendation for testing

**Critique 2**: "SpO2 94% warrants closer monitoring"
- **Severity**: 0.7
- **Defense**: "Within acceptable range for mild-moderate infection"
- **Result**: Path validated with monitoring recommendation

### 4. Verdict Synthesis

**Primary Path**: Intentional (goal-oriented diagnosis)
- **Rationale**: Best balances clinical context with diagnostic goals
- **Certainty**: 82% (high confidence)
- **Recommendations**: PCR testing, chest X-ray, symptomatic treatment

## Advanced Usage

### Custom Configuration

```python
from judicial_reasoning_framework import (
    JudicialReasoningFramework,
    ForensicConfig,
    MultiPathConfig,
    VerdictConfig
)

# Configure for medical domain
forensic_config = ForensicConfig(
    min_facts=3,
    enable_domain_detection=True,
    domain_hint="medical"
)

multipath_config = MultiPathConfig(
    enable_all_paths=True,
    min_confidence=0.7
)

verdict_config = VerdictConfig(
    min_certainty=0.6,
    enable_recommendations=True
)

# Initialize with custom config
jrf = JudicialReasoningFramework(
    forensic_config=forensic_config,
    multipath_config=multipath_config,
    verdict_config=verdict_config
)

verdict = jrf.run_protocol(patient_case)
```

### Integration with Medical Systems

```python
from judicial_reasoning_framework import JudicialReasoningFramework
import json

class MedicalDiagnosisSystem:
    def __init__(self):
        self.jrf = JudicialReasoningFramework()
    
    def analyze_patient(self, patient_data: dict) -> dict:
        """Analyze patient data and return diagnostic verdict"""
        
        # Format patient data
        case_text = self._format_patient_data(patient_data)
        
        # Run JRF protocol
        verdict = self.jrf.run_protocol(case_text)
        
        # Return structured result
        return {
            "patient_id": patient_data["id"],
            "diagnosis": verdict.conclusion,
            "certainty": verdict.certainty,
            "justification": verdict.justification,
            "recommendations": verdict.recommendations,
            "timestamp": verdict.metadata.rendered_at
        }
    
    def _format_patient_data(self, data: dict) -> str:
        """Format patient data for JRF"""
        return f"""
        Patient ID: {data['id']}
        Age: {data['age']}
        Symptoms: {', '.join(data['symptoms'])}
        Duration: {data['duration']}
        Medical History: {data.get('history', 'None')}
        """

# Usage
system = MedicalDiagnosisSystem()

patient = {
    "id": "P-2024-001",
    "age": 45,
    "symptoms": ["fever", "cough", "fatigue"],
    "duration": "3 days",
    "history": "No chronic conditions"
}

result = system.analyze_patient(patient)
print(json.dumps(result, indent=2))
```

## Best Practices

### 1. Provide Complete Information

✅ **Good**:
```python
case = """
Patient: 45M
Symptoms: Fever 38.5°C, dry cough, SOB
Duration: 3 days
Vitals: HR 92, BP 128/82, SpO2 94%
History: No chronic conditions
Exposure: Sick colleague 5 days ago
"""
```

❌ **Bad**:
```python
case = "Patient has fever and cough"
```

### 2. Use Domain-Specific Configuration

```python
# Medical domain
forensic_config = ForensicConfig(domain_hint="medical")

# Legal domain
forensic_config = ForensicConfig(domain_hint="legal")
```

### 3. Act on Recommendations

```python
verdict = jrf.run_protocol(patient_case)

# Check certainty
if verdict.certainty < 0.7:
    print("Low certainty - recommend specialist consultation")

# Check recommendations
for rec in verdict.recommendations:
    if "test" in rec.lower():
        print(f"Recommended test: {rec}")
```

## Next Steps

- [Legal Analysis Example](legal-analysis.md)
- [Financial Compliance Example](financial-compliance.md)
- [API Reference](../api/python-api.md)
