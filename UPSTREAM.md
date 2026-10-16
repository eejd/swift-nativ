# Local branch: what it carries

`local` = upstream release `v0.4.1` + the topic branches below (docs/development-model.md in
eejd/macports-ports-local, "Forks, upstreams and port tiers"). `main` mirrors
`Blaizzy/nativ` `main`; the only fork-specific content lives on `topic/*` and `local`.

| Topic | What | Upstream PR status |
|---|---|---|
| `topic/external-build-mode-validation` | Build phase: adds `NATIV_SKIP_PYTHON_RESOURCE_BUILD=EXTERNAL` (the mlx-vlm server is provided out of band, nothing is embedded; `NATIV_SERVER_DISTRIBUTION` points the app at it), makes any value other than `NO`, `YES` or `EXTERNAL` an error instead of silently running the full CPython build, and documents the three modes in the README. No change to what the app does in a default build. Upstream has no `EXTERNAL` mode, so the MacPorts port (`nativ-local`) needs this commit. | not submitted |

The MacPorts packaging edits (Sparkle switch-off, CoreML precompiled model, signing) are
`patchfiles` of the port, not commits here.
