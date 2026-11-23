# Coding-Workflow

Reusable AI software engineering workflow rules and templates designed for working safely in existing codebases with **Manual Implementation Control** (syntax guidance first, human applies changes).

## Included Files

| File | Purpose |
| --- | --- |
| `AGENTS.md` | Core engineering principles, Manual Implementation Control, efficiency sizing (`Small` / `Medium` / `Large`), security rules, and project map rules. |
| `PROJECT-MAP.md` | Blank project map template (`Status: NOT INITIALIZED`) populated once per target repo with stable codebase facts. |
| `LARGE-CHANGES.md` | Full phased analysis workflow used only for tasks classified as `Large`. |
| `HANDOFF.md` | Session handoff template for carrying task state across sessions. |
| `workflow-install.ps1` | PowerShell installer script that downloads the 4 workflow files into `./docs/Coding-Workflow/` in your project root. |

## Quick Install (PowerShell)

Open a terminal, `cd` into your target project's root directory, and run:

```powershell
# Default: downloads workflow files and skips any that already exist
irm https://raw.githubusercontent.com/Yongbi21/Coding-Workflow/main/workflow-install.ps1 | iex 
```

To overwrite existing workflow files (warning: this replaces `PROJECT-MAP.md` and `HANDOFF.md` if present):

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/Yongbi21/Coding-Workflow/main/workflow-install.ps1))) -Force
```

### What Gets Installed

Only the 4 workflow files are downloaded into `./docs/Coding-Workflow/` (`docs` is created automatically if missing; existing files inside `docs` are untouched):
- `AGENTS.md`
- `PROJECT-MAP.md`
- `LARGE-CHANGES.md`
- `HANDOFF.md`

`README.md` and `workflow-install.ps1` are intentionally excluded.

## Usage in a Target Project

1. Configure your AI coding assistant to load `docs/Coding-Workflow/AGENTS.md` as project rules.
2. On the first session, the agent runs discovery once and populates `docs/Coding-Workflow/PROJECT-MAP.md` (`Status: INITIALIZED`).
3. Tasks are scaled automatically:
   - **Small:** 1 file, no logic/DB/caller impact -> targeted syntax guidance (`A–D`).
   - **Medium:** 2–4 files or logic/query changes -> short impact note + syntax guidance (`A–D`).
   - **Large:** 5+ files, shared code, schema changes, or new modules -> phased workflow in `LARGE-CHANGES.md`.
4. Use **Default Mode** (automatic), **`draft mode`** (opt-in per task), and **`handoff`** (between sessions) as described below.

## How Modes & Handoff Work

### Default Mode (Normal — Always On)

By default, `AGENTS.md` enforces **Manual Implementation Control**:
- **Syntax guidance only:** The AI provides minimal code fragments, signatures, templates, and line-level `old -> new` snippets — never full functions, classes, or complete copy-pasteable production files.
- **No direct source edits:** You write and apply every code change yourself. The only file the AI is allowed to edit directly is `PROJECT-MAP.md` (unless you explicitly instruct otherwise).
- **Mandatory `A–D` format:** Every proposed change includes **A** (What to change), **B** (Where), **C** (Exact minimal syntax reference), and **D** (Step-by-step manual instructions), ending with `"Confirm if this syntax is correct before applying changes."`
- **Best for:** Existing or legacy codebases, bug fixes, risky logic, and staying in full control of every line you commit.

### Draft Mode (Opt-In)

Say **`draft mode`** anywhere in your prompt (no strict syntax required) when you want complete code output:
- **What changes:** The fragment-only limit is lifted — the AI can output full functions, classes, boilerplate, or unit tests in chat.
- **What stays the same:** Analysis, task sizing (`Small`/`Medium`/`Large`), risk floor, security rules, warnings, and the confirmation line all still apply. The AI **still does not edit your source files directly**; the output is a draft for you to review and apply.
- **Single-task default (auto-reset):** Saying `draft mode` applies to **that task only** and automatically reverts to Default Mode on the next task.
- **Extended session override:** If you want Draft Mode to stay active across multiple tasks (e.g., scaffolding several files in one session), explicitly say **`keep draft mode on for this session until I say normal/default mode`** (covered by Rule 7: human decision wins). It stays on until you switch back and resets in a new session. *(In very long chats or after context compaction, give a quick reminder if the AI reverts.)*
- **Best for:** Repetitive boilerplate, test suites, scaffolds, or new standalone scripts.

| Behavior | Default Mode | Draft Mode |
| --- | --- | --- |
| Activation | Automatic | Say `draft mode` (or `keep draft mode on` for a session) |
| Duration | Every task | Single task by default (auto-resets), or until you say `normal`/`default mode` |
| Code output | Minimal fragments & `old -> new` snippets | Full functions, classes, boilerplate, tests |
| AI edits source files? | No | No (review & apply manually) |
| Sizing, risk floor & security rules | Enforced | Enforced |

### Handoff (`HANDOFF.md`)

Say **`handoff`** before ending a session or starting a fresh chat context:
1. **Generating the handoff:** The AI summarizes the **whole session** (facts and decisions only — no code) into the structured template (`Done`, `Still to do`, `Lacking`, `Agendas not hit`, `User decisions`, `Assumptions`, `Touched / to touch`, `Next step`). It outputs the text without editing files directly so you can copy it into `docs/Coding-Workflow/HANDOFF.md`.
2. **Resuming in the next session:** The AI reads `PROJECT-MAP.md` first, then `HANDOFF.md` last.
3. **Verify before trusting:** The next session treats `HANDOFF.md` as a claim, not a guaranteed fact — the AI re-reads the actual code it names before giving syntax and keeps `Lacking` and `Assumptions` open until verified.
