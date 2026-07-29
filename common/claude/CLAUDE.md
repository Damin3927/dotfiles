# CLAUDE.md

These preferences apply across all my projects. A project-local `CLAUDE.md` / `AGENTS.md` takes precedence on conflict.

## Communication

- 日本語で話しかけたら日本語で返答してOK。
- Code, comments, commit messages, PR descriptions, issue text: **English only, never Japanese.**
- Use plain, natural wording in both Japanese and English, especially in documents and status reports. Don't invent terms or coin new words — use the ordinary word that already exists for the thing.
- Match written deliverables (reports, design docs, summaries) to what the task needs — no filler sections, redundant summaries, or boilerplate.

## Type safety

- Prefer type-safe approaches in every language. Don't silence the type checker to make an error go away — find the real fix. If a suppression is genuinely unavoidable, narrow it to the specific error and leave a comment saying why.
- Validate untrusted input at the boundary with a schema library, not ad-hoc runtime checks.

## Comments

- Keep comments to a minimum. Most code is self-descriptive — a comment that restates what the code already says is noise and just bloats the line count. Don't write those.
- Comment only what the code can't tell you on its own: the non-obvious *why* (intent, tradeoffs, workarounds, context links), surprising constraints, or genuinely tricky logic that isn't clear from reading.
- Reach for a clearer name or simpler structure before reaching for a comment.

## Approach

- If the right approach for a non-trivial change isn't clear, surface options and tradeoffs before implementing — don't guess and rewrite later.
- When two patterns in the codebase contradict, pick one (more recent / more tested) and flag the other. Don't silently blend them.

## Knowledge organization

Where to store things I should remember or that should persist across sessions:

- **Cross-machine / cross-project rules and conventions** → this file (`CLAUDE.md`), or `~/.claude/rules/` for rules that only apply to certain languages or paths. Synced via dotfiles, so the same content applies on every machine.
- **Project-specific knowledge** (this project's quirks, in-flight work, local context) → auto memory at `~/.claude/projects/<slug>/memory/`. **Local-only, not synced** across machines on purpose.
- **Personal info / env vars / machine-or-account-specific IDs** (e.g. `WISTERIA_GROUP`, ssh hosts, account names) → the sibling private repo `dotfiles-priv` at `../dotfiles-priv`. Sourced automatically by `common/zsh/template.zsh` when present.

When the user says "remember X", pick the right home from the list above. If unsure, ask which scope.
