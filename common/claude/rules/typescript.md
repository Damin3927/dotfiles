---
paths:
  - "**/*.{ts,tsx,mts,cts,js,jsx,mjs,cjs}"
---

# TypeScript / JavaScript

- Prefer type-safe approaches. Avoid `any` and `as` casting — find the real fix instead of silencing the type checker.
- Validate untrusted input at boundaries with a schema library (`zod` or whatever the project uses), not ad-hoc runtime guards.
- Prefer static `import` at the top of the file over `await import(...)`. Use dynamic imports only with a concrete reason (code splitting, optional dependency).
