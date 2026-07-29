---
paths:
  - "**/*.{ts,tsx,mts,cts,js,jsx,mjs,cjs}"
---

# TypeScript / JavaScript

- Escape hatches to avoid: `any`, `as` casting, `@ts-ignore`.
- `zod` for boundary validation when the project hasn't already picked something.
- Prefer static `import` at the top of the file over `await import(...)`. Use dynamic imports only with a concrete reason (code splitting, optional dependency).
