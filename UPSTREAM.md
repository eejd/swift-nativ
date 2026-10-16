# Local branch: what it carries

`local` = upstream release `v0.4.1` + the topic branches below (docs/development-model.md in
eejd/macports-ports-local, "Forks, upstreams and port tiers"). `main` is meant to mirror
`Blaizzy/nativ` `main`; the only fork-specific content lives on `topic/*` and `local`.

| Topic | What | Upstream PR status |
|---|---|---|
| `topic/external-build-mode-validation` | Build phase: any `NATIV_SKIP_PYTHON_RESOURCE_BUILD` value other than `NO`, `YES` or `EXTERNAL` is an error instead of silently running the full CPython build; the three modes are documented in the README. Build-script/docs only; no change to what the app does at runtime. | not submitted |

The MacPorts packaging edits (Sparkle switch-off, CoreML precompiled model, signing) are
`patchfiles` of the port, not commits here.
