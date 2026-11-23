# Coding-Workflow

Reusable AI software engineering workflow rules and templates designed for working safely in existing codebases with **Manual Implementation Control** (syntax guidance first, human applies changes).

## Included Files

| File | Purpose |
| --- | --- |
| `AGENTS.md` | Core engineering principles, Manual Implementation Control, efficiency sizing (`Small` / `Medium` / `Large`), security rules, and project map rules. |
| `PROJECT_MAP.md` | Blank project map template (`Status: NOT INITIALIZED`) populated once per target repo with stable codebase facts. |
| `LARGE-CHANGES.md` | Full phased analysis workflow used only for tasks classified as `Large`. |
| `HANDOFF.md` | Session handoff template for carrying task state across sessions. |
| `workflow-install.ps1` | PowerShell installer script that downloads the 4 workflow files into your current project root. |

## Quick Install (PowerShell)

Open a terminal, `cd` into your target project's root directory, and run:

```powershell
# Default: downloads workflow files and skips any that already exist
irm https://raw.githubusercontent.com/Yongbi21/Coding-Workflow/main/workflow-install.ps1 | iex 
```

To overwrite existing workflow files (warning: this replaces `PROJECT_MAP.md` and `HANDOFF.md` if present):

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/Yongbi21/Coding-Workflow/main/workflow-install.ps1))) -Force
```

### What Gets Installed

Only the 4 workflow files are downloaded into your current working directory:
- `AGENTS.md`
- `PROJECT_MAP.md`
- `LARGE-CHANGES.md`
- `HANDOFF.md`

`README.MD` and `workflow-install.ps1` are intentionally excluded.

## Usage in a Target Project

1. Configure your AI coding assistant to load `AGENTS.md` as project rules.
2. On the first session, the agent runs discovery once and populates `PROJECT_MAP.md` (`Status: INITIALIZED`).
3. Tasks are scaled automatically:
   - **Small:** 1 file, no logic/DB/caller impact -> targeted syntax guidance (`A–D`).
   - **Medium:** 2–4 files or logic/query changes -> short impact note + syntax guidance (`A–D`).
   - **Large:** 5+ files, shared code, schema changes, or new modules -> phased workflow in `LARGE-CHANGES.md`.
4. Say **`draft mode`** to opt in to full code drafts for a single task (still reviewed and applied manually).
5. Say **`handoff`** to generate a structured summary for `HANDOFF.md` before ending a session.
