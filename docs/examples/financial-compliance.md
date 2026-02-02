# Financial Compliance Example

This example demonstrates using JRF for financial transaction compliance analysis.

## Scenario

Analyzing a series of transactions for potential fraud or compliance violations.

## Complete Code

```python
from judicial_reasoning_framework import JudicialReasoningFramework

jrf = JudicialReasoningFramework()

# Transaction data
transaction_case = """
TRANSACTION ANALYSIS REQUEST

Account: ABC-123456
Account Holder: John Smith
Account Type: Business Checking
Industry: Import/Export

RECENT TRANSACTIONS (Last 7 days):

Day 1:
- Wire transfer OUT: $45,000 to offshore account (Cayman Islands)
- Cash deposit: $15,000

Day 2:
- Wire transfer OUT: $38,000 to same offshore account
- Multiple small deposits: $2,500, $3,200, $2,800 (total $8,500)

Day 3:
- Wire transfer OUT: $52,000 to different offshore account (Panama)
- Cash withdrawal: $9,000

Day 4-7:
- No activity

HISTORICAL PATTERN:
- Average monthly volume: $80,000
- Typical transaction size: $5,000-$15,000
- No previous offshore transfers
- Account age: 3 years
- No previous compliance flags

RED FLAGS DETECTED:
- Sudden spike in transaction volume (3x normal)
- Multiple offshore transfers (new pattern)
- Structuring pattern (deposits just under $10k reporting threshold)
- Rapid fund movement

QUESTION: Does this activity indicate potential money laundering or fraud?
What is the compliance risk level?
"""

# Run JRF analysis
print("Running JRF Financial Compliance Analysis...")
print("=" * 60)

verdict = jrf.run_protocol(transaction_case)

# Display results
print("\nVERDICT")
print("=" * 60)
print(verdict.conclusion)
print()

print(f"Certainty: {verdict.certainty:.0%}")
print(f"Risk Level: ", end="")
if verdict.certainty > 0.8:
    print("HIGH RISK")
elif verdict.certainty > 0.6:
    print("MODERATE RISK")
else:
    print("LOW RISK")
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
Running JRF Financial Compliance Analysis...
============================================================

VERDICT
============================================================
Conclusion (intentional approach): L'objectif identifié 'assess money laundering risk' 
dans le domaine financial est analysé à travers 3 chemin(x) validé(s), 
révélant des indicateurs significatifs de risque élevé.

Certainty: 87%
Risk Level: HIGH RISK

JUSTIFICATION
------------------------------------------------------------
Le chemin Intentional a été retenu comme chemin principal avec un score de 
solidité de 87%. Points forts: Multiple red flags identified, Clear pattern 
deviation, Offshore transfer pattern, Structuring indicators. L'analyse a 
identifié 15 fait(s) et 1 objectif(s). La délibération a considéré 3 chemin(x) 
et identifié 2 critique(s).

RECOMMENDATIONS
------------------------------------------------------------
1. File Suspicious Activity Report (SAR) immediately
2. Freeze account pending investigation
3. Contact account holder for explanation
4. Review historical transactions for additional patterns
5. Escalate to compliance officer
```

## Analysis Breakdown

### Forensic Deconstruction

**Facts Extracted**:
- 3x normal transaction volume
- $135,000 transferred offshore in 3 days
- Deposits structured under $10k threshold
- No previous offshore activity
- Business account (import/export)

**Desires Identified**:
- Assess money laundering risk
- Determine compliance action

**Context**: Financial compliance / AML

### Multi-Path Reasoning

**Literal Path**: Transaction pattern analysis
- Volume spike: 3x normal
- Offshore transfers: $135k total
- Structuring: Deposits $2,500-$3,200

**Intentional Path**: Risk assessment
- Goal: Identify money laundering
- Indicators: Structuring + offshore + volume spike
- Risk: HIGH (multiple red flags)

**Procedural Path**: Compliance workflow
- Step 1: Identify red flags (4 found)
- Step 2: Assess risk level (HIGH)
- Step 3: Determine action (SAR + freeze)

### Moot Court Deliberation

**Critique 1**: "Could be legitimate business activity"
- **Severity**: 0.5
- **Defense**: "Pattern inconsistent with 3-year history"
- **Result**: Validated (risk remains HIGH)

**Critique 2**: "Import/export may explain offshore transfers"
- **Severity**: 0.6
- **Defense**: "Structuring pattern + sudden change = suspicious"
- **Result**: Validated (SAR recommended)

## Compliance Actions

Based on verdict certainty:

```python
verdict = jrf.run_protocol(transaction_case)

if verdict.certainty > 0.8:
    # HIGH RISK
    actions = [
        "File SAR immediately",
        "Freeze account",
        "Escalate to compliance officer"
    ]
elif verdict.certainty > 0.6:
    # MODERATE RISK
    actions = [
        "Enhanced monitoring",
        "Request documentation",
        "Prepare SAR if pattern continues"
    ]
else:
    # LOW RISK
    actions = [
        "Continue monitoring",
        "Document review"
    ]

for action in actions:
    print(f"ACTION: {action}")
```

## Best Practices

### 1. Provide Complete Transaction History

```python
# ✅ Good: Detailed transaction data + context
case = """
Account info
Historical pattern
Recent transactions
Red flags detected
Specific question
"""

# ❌ Bad: Incomplete data
case = "Check this account for fraud"
```

### 2. Include Historical Context

```python
# ✅ Good: Compare to baseline
"Average monthly volume: $80,000"
"Typical transaction size: $5,000-$15,000"

# ❌ Bad: No baseline
"Recent transactions: $45k, $38k, $52k"
```

### 3. Act on Recommendations

```python
verdict = jrf.run_protocol(transaction_case)

# Implement recommendations
for rec in verdict.recommendations:
    if "SAR" in rec:
        file_suspicious_activity_report()
    if "freeze" in rec.lower():
        freeze_account()
    if "escalate" in rec.lower():
        notify_compliance_officer()
```

## Integration with Compliance Systems

```python
from judicial_reasoning_framework import JudicialReasoningFramework

class ComplianceMonitor:
    def __init__(self):
        self.jrf = JudicialReasoningFramework()
    
    def analyze_transaction_pattern(self, account_id: str) -> dict:
        # Fetch transaction data
        transactions = self.fetch_transactions(account_id)
        
        # Format for JRF
        case_text = self.format_case(transactions)
        
        # Run JRF analysis
        verdict = self.jrf.run_protocol(case_text)
        
        # Determine risk level
        if verdict.certainty > 0.8:
            risk_level = "HIGH"
            action = "FILE_SAR"
        elif verdict.certainty > 0.6:
            risk_level = "MODERATE"
            action = "ENHANCED_MONITORING"
        else:
            risk_level = "LOW"
            action = "CONTINUE_MONITORING"
        
        return {
            "account_id": account_id,
            "risk_level": risk_level,
            "certainty": verdict.certainty,
            "action": action,
            "justification": verdict.justification,
            "recommendations": verdict.recommendations
        }

# Usage
monitor = ComplianceMonitor()
result = monitor.analyze_transaction_pattern("ABC-123456")

if result["risk_level"] == "HIGH":
    print(f"⚠️ HIGH RISK ALERT: {result['account_id']}")
    print(f"Action: {result['action']}")
```

## Next Steps

- [Medical Diagnosis Example](medical-diagnosis.md)
- [Legal Analysis Example](legal-analysis.md)
- [API Reference](../api/python-api.md)
