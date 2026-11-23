# LARGE-CHANGES.md

Read this file ONLY when a task is classified Large in AGENTS.md (5+ files, shared/many-caller code, schema or stored procedure change, new module, or migration).

Rules from AGENTS.md still apply here: Manual Implementation Control, Security rules, and "ask only blocking questions (max 3)". Skip any item below that is already known from the map, the user's request, or earlier phases. Do not restate it.

---

# Phase 1: Codebase Discovery

If PROJECT_MAP.md is INITIALIZED, use it and only discover the area this task touches. Otherwise identify:

* Applications, services, modules, libraries, shared components
* Dependencies and configuration files
* Architecture (monolith/distributed, layered, MVC/MVVM, domain boundaries)
* Languages, frameworks, databases, APIs, build tools, CI/CD

# Phase 2: Functional Analysis

Analyze the requested area before suggesting modifications.

* Entry points: routes, endpoints, controllers, UI events, background jobs, scheduled tasks, service handlers, message consumers
* Execution flow: where it starts, which components are involved, how data moves, which business rules apply, what outputs are produced
* Dependencies: internal, external, shared utilities, APIs, services, database objects

# Phase 3: Function and Component Analysis

For every relevant function, class, service, module, or component, note:

Name, Purpose, Inputs, Outputs, Dependencies, Side Effects, Called By, Calls To, Data Sources, Risks, Modification Considerations.

Do not propose changes until this analysis is complete.

# Phase 4: Current State Summary

Concise summary of:

* Existing behavior
* Relevant components (files, modules, services, functions, tables, APIs)
* Data flow
* Constraints (business and technical)
* Potential risks (what could break)

# Phase 5: Ask for Agenda

If the objective is not already clear, ask the user to define it (new feature, bug fix, refactor, optimization, integration, migration, reporting, security enhancement, infrastructure change). Do not assume the objective.

# Phase 6: Requirements Gathering

Confirm, asking only what is missing:

* Objective and business context
* Current behavior vs desired behavior
* Scope and non-goals (what must NOT change)
* Constraints
* Security, performance, reliability, and compatibility requirements
* Acceptance criteria

# Phase 7: Impact Analysis

Before any syntax guidance, list:

* Affected files, components, services, APIs
* Affected database objects
* Affected infrastructure and integrations
* Potential breaking changes
* Testing requirements

# Phase 8: Solution Design

* Summary
* Architecture and data flow changes (if any)
* Component changes (which modules change)
* Database changes (schema, procedures, queries, migrations)
* API changes (endpoints, contracts, payloads)
* Security and performance considerations
* Risks
* Alternatives considered

# Phase 9: Implementation Plan

Step-by-step. For each step:

* Objective
* Components affected
* Risks
* Validation method

Wait for the user's approval of the plan before Phase 10.

# Phase 10: Syntax Guidance (not code generation)

Follow Manual Implementation Control in AGENTS.md: give the A-D format for each plan step, fragments only. The user writes and applies all code (unless the user has said "draft mode" for this task).

* Follow existing patterns (naming, folder structure, architecture, coding standards).
* Minimize scope: only what is necessary.
* No unrelated refactoring unless requested.
* For every modification state: why it is needed, what it changes, potential side effects.

# Phase 11: Validation Checklist (for the user to run)

The user applies the changes, so give a checklist to run and report back on:

* Functionality: requirements and acceptance criteria met
* Side effects: impacted areas still behave correctly
* Compatibility: existing functionality intact
* Security: permissions and protections still work
* Performance: no significant regression

After the user reports results, re-check anything that failed or was not run.

---

# Response Format for Large Requests

1. Codebase Discovery
2. Functional Analysis
3. Current State Summary
4. Agenda Clarification
5. Requirements Gathering
6. Impact Analysis
7. Solution Design
8. Implementation Plan (wait for approval)
9. Syntax Guidance (A-D per step)
10. Validation Checklist

Give these in stages, not all at once: stop for the user at Phase 5 (if the objective is unclear), Phase 6 (if requirements are missing), and Phase 9 (approval). Never skip analysis of the code path involved. Never assume requirements.
