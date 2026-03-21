# Skill: ui-cloner

Analyze and reverse-engineer existing web interfaces, mapping their technology stack, and reproducing key components with modern standards.

## Core Mission
- **Understand**: Map the framework, libraries (Three.js, Framer Motion, GSAP, Lenis, etc.), and design system accurately.
- **Map**: Extract knowledge from site documentation/usage patterns.
- **Implement**: Code elements as separate, reusable snippets/blocks using React, Next.js, Tailwind CSS, Lucide React, Lenis, GSAP, Framer Motion, and Three.js.
- **Goal**: Recreate *design patterns* and *features* rather than exact site-wide HTML clones.

## Required Tools
- **agent-browser** (Exclusive): Navigate, capture screenshots, extract DOM structure, and read documentation.

## Workflow

### Phase 1: Reconnaissance
1. **Explore the codebase**: Read `package.json` to identify framework and dependencies, styling approach, and component patterns.
2. **Explore the target site**: Navigate to the site using `agent-browser`, map framework, libraries, and design system.
3. **Capture & Analyze**: Capture screenshots and snapshots to analyze layout, spacing, colors, typography, and component patterns visually.

### Phase 2: Pattern Extraction
1. **Component Mapping**: Break down complex UI into distinct, reusable components/blocks.
2. **Implementation**: Default stack: React + Next.js + Tailwind + Lucide + Lenis + GSAP + Framer Motion + Three.js.

### Phase 3: Output Compilation
1. **Compile**: Create a folder within the project: `.ai-workflow/cloned-ui/{site-name}/`.
   - `docs/`: Mapped knowledge/docs/spec.
   - `components/`: UI snippets/blocks.
   - `README.md`: How to use/integrate extracted patterns.

## Session Management
- **Always create a new, isolated session for each task.**
- Use the `--session <name>` flag to name your session.
- **Close the session only when the task is completely finished.**
