# PROJECT_MAP.MD

Status: NOT INITIALIZED
Last updated: never
Checked up to: never

<!--
Agent rules for this file:
- If Status is NOT INITIALIZED: run discovery once, fill every section,
  set Status to INITIALIZED, Last updated to today's date, and
  "Checked up to" to the newest source-file modified time seen.
- "Checked up to" is a file modified time from the codebase's own location
  (not the local clock). Used to find files changed since.
- Stable facts only. One line per fact. Write "unknown" if not found.
- No line numbers or fast-changing logic. No secret values (config
  LOCATION is fine, contents are not).
- Keep under ~100 lines. Add new facts as short lines; do not rewrite.
- If code contradicts this file, say so and correct the line.
-->

## Stack
<!-- languages, frameworks + versions, databases, build tools -->

## Solution layout
<!-- project/folder -> role -->

## Modules
<!-- Feature: entry point -> class/service -> DB objects (SPs/tables) -->

## High-risk areas
<!-- money/financial logic, auth/permissions, personal data, shared code
with many callers, migrations, destructive jobs, external integrations -->

## Conventions
<!-- naming, folder patterns, error handling, template module to copy -->

## Known pitfalls
<!-- recurring bug patterns and gotchas in THIS codebase -->

## Data & config
<!-- backends, key tables per module, config/connection file LOCATIONS
(never values), test database if any -->

## Testing
<!-- framework and location, or "none, manual testing only" -->

## Do not scan
<!-- build output, vendor dirs, logs, backups, generated files -->

## Build / run
<!-- how to build, run, test, deploy -->
