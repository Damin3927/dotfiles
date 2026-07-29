---
paths:
  - "**/*.{py,pyi}"
---

# Python

- Escape hatches to avoid: `Any`, `cast()`, `# type: ignore`. When an untyped third-party library forces one, narrow it to the specific error code (`# type: ignore[attr-defined]`) rather than blanket-ignoring the line.
- Annotate parameters and return types on functions that cross a module boundary. Local helpers can stay inferred.
- `pydantic` for boundary validation when the project hasn't already picked something.
