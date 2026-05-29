# CLAUDE.md

These preferences apply across all my projects. A project-local `CLAUDE.md` / `AGENTS.md` takes precedence on conflict.

## Communication

- 日本語で話しかけたら日本語で返答してOK。
- Code, comments, commit messages, PR descriptions, issue text: **English only, never Japanese.**

## Type safety

- Prefer type-safe approaches. Avoid `any` and `as` casting — find the real fix instead of silencing the type checker.
- Validate untrusted input at boundaries with a schema library (`zod` or whatever the project uses), not ad-hoc runtime guards.
- Prefer static `import` at the top of the file over `await import(...)`. Use dynamic imports only with a concrete reason (code splitting, optional dependency).

## Comments

- Keep comments to a minimum. Most code is self-descriptive — a comment that restates what the code already says is noise and just bloats the line count. Don't write those.
- Comment only what the code can't tell you on its own: the non-obvious *why* (intent, tradeoffs, workarounds, context links), surprising constraints, or genuinely tricky logic that isn't clear from reading.
- Reach for a clearer name or simpler structure before reaching for a comment.

## Approach

- If the right approach for a non-trivial change isn't clear, surface options and tradeoffs before implementing — don't guess and rewrite later.
- Before changing code that touches an interface, read its exports, callers, and shared utilities. "Looks orthogonal" is dangerous.
- Match the codebase's existing conventions even when you disagree. If a convention seems actively harmful, surface it — don't fork silently.
- When two patterns in the codebase contradict, pick one (more recent / more tested) and flag the other. Don't silently blend them.

## Verification

- "Done" means verified. Run the project's typecheck / lint / tests when the change is non-trivial. If a check was skipped (no command, env not set up, sandbox limits), say so explicitly.

## Knowledge organization

Where to store things I should remember or that should persist across sessions:

- **Cross-machine / cross-project rules and conventions** → this file (`CLAUDE.md`). Synced via dotfiles, so the same content applies on every machine.
- **Project-specific knowledge** (this project's quirks, in-flight work, local context) → that project's `~/.claude/projects/<slug>/memory/`. **Local-only, not synced** across machines on purpose.
- **Personal info / env vars / machine-or-account-specific IDs** (e.g. `WISTERIA_GROUP`, ssh hosts, account names) → the sibling private repo `dotfiles-priv` at `../dotfiles-priv`. Sourced automatically by `common/zsh/template.zsh` when present.

When the user says "remember X", pick the right home from the list above. If unsure, ask which scope.
