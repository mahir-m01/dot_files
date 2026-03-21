# Contract-Based Agent Workflow

> A structured handoff pattern for multi-agent collaboration with cost efficiency and traceability.

---

## Overview

This workflow separates **thinking** (expensive) from **writing** (cheap) from **implementation** (variable). The architect designs, a cheap assistant documents, and specialized agents execute against written contracts.

```
┌─────────────┐      ┌──────────────────┐      ┌─────────────┐
│ @architect  │ ───► │ @scribe-assistant│ ───► │ @frontend   │
│ (Opus/Deep) │      │ (Haiku 4.5)      │      │ @backend    │
│             │      │                  │      │ @shield     │
│ Thinks &    │      │ Writes contract  │      │ @ops        │
│ Designs     │      │ to disk          │      │             │
└─────────────┘      └──────────────────┘      └─────────────┘
       │                                              │
       │                                              ▼
       │                                   ┌──────────────────┐
       │                                   │ Agent writes     │
       │                                   │ completion log   │
       │                                   └──────────────────┘
       │                                              │
       ◄──────────────────────────────────────────────┘
       │
       ▼
┌─────────────┐
│ @architect  │
│ reads log,  │
│ decides     │
│ next step   │
└─────────────┘
```

---

## Why This Pattern?

| Problem | Solution |
|---------|----------|
| Expensive models waste tokens on boilerplate | Cheap Haiku 4.5 handles all writing |
| No audit trail of decisions | Contracts and logs persisted to disk |
| Context lost between agent hops | Written contracts preserve full context |
| Manual coordination overhead | Structured handoff with clear paths |
| Model selection at runtime | Pre-defined models per agent role |

---

## Directory Structure

Every project using this workflow should have:

```
{project}/
└── .ai-workflow/
    └── contracts/
        ├── frontend-contract-1.md      # Pending contract
        ├── frontend-contract-1-log.md  # Completion log
        ├── frontend-contract-2.md
        ├── backend-contract-1.md
        ├── backend-contract-1-log.md
        └── ...
```

---

## Agent Roles

### @architect (Expensive Model)
- **Model**: Opus or deep-thinking model
- **Role**: Strategic thinking, system design, pattern selection
- **Output**: Verbal instructions to @scribe-assistant
- **Reads**: Completion logs to decide next steps

### @scribe-assistant (Cheap Model)
- **Model**: `github-copilot/claude-haiku-4.5`
- **Role**: Document writer, contract formatter
- **Output**: Contract files written to `.ai-workflow/contracts/`
- **Never**: Implements code or makes design decisions

### @frontend, @backend, @shield, @ops (User's Preferred Model)
- **Model**: User's choice (manually invoked)
- **Role**: Implementation against contract spec
- **Input**: Reads assigned contract from disk
- **Output**: Code + completion log

---

## Workflow Steps

### Phase 1: Design (Architect)
```
1. User requests feature
2. @architect analyzes requirements
3. @architect produces high-level design
4. User approves design ("LFG" or "Approved")
```

### Phase 2: Contract Writing (Scribe)
```
5. @architect delegates to @scribe-assistant
6. @scribe-assistant writes contract to .ai-workflow/contracts/
7. @scribe-assistant confirms file created with path
```

### Phase 3: Implementation (Domain Agent)
```
8. User manually invokes target agent with preferred model
9. Agent reads contract from disk
10. Agent implements per contract spec
11. Agent writes completion log to same directory
```

### Phase 4: Review (Architect)
```
12. @architect reads completion log
13. @architect decides: done, iterate, or next contract
14. Cycle repeats until feature complete
```

---

## Contract Format

```markdown
# Contract: {descriptive-name}

**ID**: {domain}-contract-{number}
**Created**: {YYYY-MM-DD}
**Target Agent**: @{agent-name}
**Status**: pending | in_progress | completed | blocked

## Objective
{Single sentence: what needs to be done}

## Context
{Background the implementing agent needs to understand}

## Requirements
1. {Specific, measurable requirement}
2. {Specific, measurable requirement}

## Acceptance Criteria
- [ ] {Checkable outcome}
- [ ] {Checkable outcome}

## References
- {Path to relevant files}
- {Link to prior contracts}

## Notes
{Constraints, warnings, or additional context}
```

---

## Completion Log Format

```markdown
# Log: {contract-name}

**Contract**: {contract-id}
**Completed**: {YYYY-MM-DD}
**Agent**: @{agent-name}

## Summary
{2-3 sentences: what was accomplished}

## Changes Made
- `path/to/file.ts`: {Brief description}
- `path/to/file.css`: {Brief description}

## Decisions
- {Decision made during implementation and why}

## Issues Encountered
- {Problem faced and resolution}

## Next Steps
- {Suggested follow-up, or "None — contract complete"}
```

---

## Manual Invocation Pattern

Since OpenCode doesn't support runtime model selection, users manually invoke agents:

```
# User types in terminal:
@frontend Read the contract at .ai-workflow/contracts/frontend-contract-1.md and implement it.

# Or with explicit model preference in agent definition:
# The @frontend agent should have model: configured in its frontmatter
```

---

## Best Practices

### For Architects
- Keep contracts atomic — one clear objective
- Include all context the agent needs (don't assume)
- Reference specific file paths, not vague "the component"
- Define acceptance criteria that are verifiable

### For Scribe
- Use numbered IDs for traceability
- Save to `.ai-workflow/contracts/` always
- Match the template format exactly
- Never add implementation details or opinions

### For Implementing Agents
- Read the full contract before starting
- Write completion log immediately after finishing
- Note any deviations from the contract spec
- Suggest follow-up contracts in "Next Steps" if scope expanded

---

## Example Session

```
User: I need a dark mode toggle in settings

@architect: [Designs system: state management, component structure, CSS approach]
@architect: "I'll have the scribe write up the first contract for the toggle component."

@scribe-assistant: [Writes frontend-contract-1.md to disk]
@scribe-assistant: "Contract created at .ai-workflow/contracts/frontend-contract-1.md"

User: @frontend Implement the contract at .ai-workflow/contracts/frontend-contract-1.md

@frontend: [Reads contract, implements toggle, writes completion log]
@frontend: "Done. Completion log at .ai-workflow/contracts/frontend-contract-1-log.md"

User: @architect Review the completion log and decide next steps

@architect: [Reads log, sees toggle complete, decides CSS theming is next]
@architect: "Toggle complete. Next contract: CSS custom properties for theme colors."
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Agent doesn't see contract | Ensure path is `.ai-workflow/contracts/` (with dot prefix) |
| Wrong model used | Check agent's frontmatter has `model:` field set |
| Context lost between sessions | Contracts persist to disk — always reference the file |
| Scribe makes design decisions | Re-delegate to @architect for any ambiguity |

---

<commentary>
This workflow maximizes cost efficiency (Haiku for writing, expensive models for thinking), traceability (all decisions on disk), and flexibility (user chooses model at invocation). The contract pattern is inspired by API contracts and design-by-contract principles, adapted for multi-agent orchestration.
</commentary>
