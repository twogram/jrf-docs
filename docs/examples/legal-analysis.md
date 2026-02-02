# Legal Analysis Example

This example demonstrates using JRF for legal contract analysis.

## Scenario

Analyzing a software license agreement for compliance and potential issues.

## Complete Code

```python
from judicial_reasoning_framework import JudicialReasoningFramework

jrf = JudicialReasoningFramework()

# Contract text
contract = """
SOFTWARE LICENSE AGREEMENT

1. LICENSE GRANT
Licensor grants Licensee a non-exclusive, non-transferable license to use
the Software for internal business purposes only.

2. RESTRICTIONS
Licensee shall not:
- Reverse engineer, decompile, or disassemble the Software
- Sublicense, rent, or lease the Software to third parties
- Remove or modify any proprietary notices

3. TERM AND TERMINATION
This Agreement is effective upon acceptance and continues for 12 months.
Either party may terminate with 30 days written notice.
Upon termination, Licensee must destroy all copies of the Software.

4. WARRANTY DISCLAIMER
THE SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND.
LICENSOR DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED.

5. LIMITATION OF LIABILITY
IN NO EVENT SHALL LICENSOR BE LIABLE FOR ANY INDIRECT, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF USE OF THE SOFTWARE.
TOTAL LIABILITY SHALL NOT EXCEED THE LICENSE FEE PAID.

6. GOVERNING LAW
This Agreement shall be governed by the laws of Delaware.

QUESTION: Is this agreement favorable to the Licensee?
What are the key risks?
"""

# Run JRF analysis
print("Running JRF Legal Analysis...")
print("=" * 60)

verdict = jrf.run_protocol(contract)

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
```

## Expected Output

```
Running JRF Legal Analysis...
============================================================

VERDICT
============================================================
Conclusion (intentional approach): L'objectif identifié 'evaluate contract favorability' 
dans le domaine legal est analysé à travers 3 chemin(x) validé(s), 
révélant plusieurs risques significatifs pour le Licensee.

Certainty: 78%
Primary Reasoning Path: PathType.Intentional

JUSTIFICATION
------------------------------------------------------------
Le chemin Intentional a été retenu comme chemin principal avec un score de 
solidité de 78%. Points forts: Clear legal structure, Explicit terms, 
Standard clauses. Points faibles: Broad warranty disclaimer, Limited liability 
cap, One-sided termination rights. L'analyse a identifié 12 fait(s) et 
1 objectif(s). La délibération a considéré 3 chemin(x) et identifié 4 critique(s).

RECOMMENDATIONS
------------------------------------------------------------
1. Négocier garanties minimales pour le Software
2. Clarifier la limitation de responsabilité
3. Ajouter clause de résolution de litiges
4. Réviser les droits de terminaison
```

## Analysis Breakdown

### Forensic Deconstruction

**Facts Extracted**:
- Non-exclusive, non-transferable license
- Internal business use only
- 12-month term
- 30-day termination notice
- "AS IS" warranty disclaimer
- Liability limited to license fee
- Delaware governing law

**Desires Identified**:
- Evaluate contract favorability
- Identify key risks

**Context**: Legal contract analysis

### Multi-Path Reasoning

**Literal Path**: Direct clause analysis
- License is restrictive (non-transferable)
- Warranty is fully disclaimed
- Liability is capped

**Intentional Path**: Risk assessment
- Goal: Protect Licensee interests
- Risk 1: No warranties → Software may be defective
- Risk 2: Limited liability → Damages not recoverable
- Risk 3: One-sided termination → Licensor can exit easily

**Procedural Path**: Compliance review
- Step 1: Review license grant (restrictive)
- Step 2: Check restrictions (standard)
- Step 3: Assess termination (balanced)
- Step 4: Evaluate warranties (unfavorable)

### Moot Court Deliberation

**Critique 1**: "Warranty disclaimer is too broad"
- **Severity**: 0.8
- **Defense**: "Standard in software licenses"
- **Result**: Validated with recommendation

**Critique 2**: "Liability cap is insufficient"
- **Severity**: 0.7
- **Defense**: "Common practice, but negotiable"
- **Result**: Validated with recommendation

## Best Practices

### 1. Provide Complete Contract Text

```python
# ✅ Good: Full contract with context
contract = """
[Full contract text]

QUESTION: Specific legal question
"""

# ❌ Bad: Incomplete or vague
contract = "Is this contract good?"
```

### 2. Ask Specific Questions

```python
# ✅ Good: Specific question
"Is this agreement favorable to the Licensee? What are the key risks?"

# ❌ Bad: Vague question
"Analyze this contract"
```

### 3. Review Recommendations

```python
verdict = jrf.run_protocol(contract)

# Act on recommendations
for rec in verdict.recommendations:
    if "négocier" in rec.lower():
        print(f"Negotiation point: {rec}")
```

## Next Steps

- [Financial Compliance Example](financial-compliance.md)
- [Medical Diagnosis Example](medical-diagnosis.md)
- [API Reference](../api/python-api.md)
