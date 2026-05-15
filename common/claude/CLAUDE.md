# CLAUDE.md

These preferences apply across all my projects. A project-local `CLAUDE.md` / `AGENTS.md` takes precedence on conflict.

## Communication

- 日本語で話しかけたら日本語で返答してOK。
- Code, comments, commit messages, PR descriptions, issue text: **English only, never Japanese.**

## Type safety

- Prefer type-safe approaches. Avoid `any` and `as` casting — find the real fix instead of silencing the type checker.
- Validate untrusted input at boundaries with a schema library (`zod` or whatever the project uses), not ad-hoc runtime guards.
- Prefer static `import` at the top of the file over `await import(...)`. Use dynamic imports only with a concrete reason (code splitting, optional dependency).

## Approach

- If the right approach for a non-trivial change isn't clear, surface options and tradeoffs before implementing — don't guess and rewrite later.
- Before changing code that touches an interface, read its exports, callers, and shared utilities. "Looks orthogonal" is dangerous.
- Match the codebase's existing conventions even when you disagree. If a convention seems actively harmful, surface it — don't fork silently.
- When two patterns in the codebase contradict, pick one (more recent / more tested) and flag the other. Don't silently blend them.

## Verification

- "Done" means verified. Run the project's typecheck / lint / tests when the change is non-trivial. If a check was skipped (no command, env not set up, sandbox limits), say so explicitly.
