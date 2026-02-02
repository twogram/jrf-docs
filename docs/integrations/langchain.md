# Integration with LangChain

JRF integrates with [LangChain](https://python.langchain.com/) as a custom chain for rigorous reasoning.

## Installation

```bash
pip install judicial-reasoning-framework langchain
```

## Basic Integration

```python
from langchain.chains.base import Chain
from judicial_reasoning_framework import JudicialReasoningFramework
from typing import Dict, List

class JRFChain(Chain):
    """JRF as a LangChain chain"""
    
    jrf: JudicialReasoningFramework = JudicialReasoningFramework()
    
    @property
    def input_keys(self) -> List[str]:
        return ["input"]
    
    @property
    def output_keys(self) -> List[str]:
        return ["conclusion", "certainty", "justification"]
    
    def _call(self, inputs: Dict[str, str]) -> Dict[str, any]:
        verdict = self.jrf.run_protocol(inputs["input"])
        
        return {
            "conclusion": verdict.conclusion,
            "certainty": verdict.certainty,
            "justification": verdict.justification,
            "recommendations": verdict.recommendations
        }

# Usage
jrf_chain = JRFChain()
result = jrf_chain({"input": "Patient has fever for 3 days"})

print(result["conclusion"])
print(f"Certainty: {result['certainty']:.0%}")
```

## Sequential Chain

Combine JRF with other LangChain components:

```python
from langchain.chains import SequentialChain
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate
from langchain.llms import OpenAI

# Step 1: Extract information
extract_prompt = PromptTemplate(
    input_variables=["text"],
    template="Extract key information from: {text}"
)
extract_chain = LLMChain(llm=OpenAI(), prompt=extract_prompt, output_key="extracted")

# Step 2: JRF analysis
jrf_chain = JRFChain()

# Step 3: Generate report
report_prompt = PromptTemplate(
    input_variables=["conclusion", "justification"],
    template="Generate report based on:\nConclusion: {conclusion}\nJustification: {justification}"
)
report_chain = LLMChain(llm=OpenAI(), prompt=report_prompt, output_key="report")

# Combine chains
full_chain = SequentialChain(
    chains=[extract_chain, jrf_chain, report_chain],
    input_variables=["text"],
    output_variables=["report"]
)

result = full_chain({"text": "Patient medical record..."})
print(result["report"])
```

## Router Chain

Route to JRF for critical decisions:

```python
from langchain.chains.router import MultiRouteChain
from langchain.chains.router.llm_router import LLMRouterChain, RouterOutputParser

# Define routes
routes = [
    {
        "name": "jrf",
        "description": "Use for critical, high-stakes decisions requiring justification",
        "chain": JRFChain()
    },
    {
        "name": "simple",
        "description": "Use for simple, straightforward queries",
        "chain": LLMChain(llm=OpenAI(), prompt=simple_prompt)
    }
]

# Router
router_chain = MultiRouteChain(
    router_chain=LLMRouterChain(...),
    destination_chains={r["name"]: r["chain"] for r in routes},
    default_chain=JRFChain()
)

# Route automatically
result = router_chain({"input": "Diagnose patient symptoms"})  # → JRF
result = router_chain({"input": "What is 2+2?"})  # → Simple
```

## Agent Integration

Use JRF as a tool in LangChain agents:

```python
from langchain.agents import Tool, initialize_agent, AgentType
from langchain.llms import OpenAI

def jrf_tool_func(input_text: str) -> str:
    jrf = JudicialReasoningFramework()
    verdict = jrf.run_protocol(input_text)
    return f"Conclusion: {verdict.conclusion}\nCertainty: {verdict.certainty:.0%}"

jrf_tool = Tool(
    name="JRF Reasoner",
    func=jrf_tool_func,
    description="Use for rigorous reasoning with full justification. Input should be a case description."
)

tools = [jrf_tool, ...]

agent = initialize_agent(
    tools=tools,
    llm=OpenAI(),
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION
)

agent.run("Analyze this medical case: Patient has fever...")
```

## Best Practices

### 1. Use JRF for Critical Decisions

```python
# ✅ Good: JRF for high-stakes
jrf_chain({"input": "Legal contract analysis"})

# ❌ Bad: JRF for trivial queries
jrf_chain({"input": "What's the weather?"})
```

### 2. Cache Results

```python
from langchain.cache import InMemoryCache
import langchain

langchain.llm_cache = InMemoryCache()

# JRF results will be cached
jrf_chain({"input": "Same case"})  # Cached!
```

### 3. Stream Results

```python
class StreamingJRFChain(Chain):
    def _call(self, inputs: Dict[str, str]) -> Dict[str, any]:
        verdict = self.jrf.run_protocol(inputs["input"])
        
        # Stream results
        yield {"step": "forensic", "data": "..."}
        yield {"step": "multi_path", "data": "..."}
        yield {"step": "verdict", "data": verdict.conclusion}
```

## Next Steps

- [Agent-Lightning Integration](agent-lightning.md)
- [Microsoft Agent Framework Integration](microsoft-agent-framework.md)
- [Examples](../examples/medical-diagnosis.md)
