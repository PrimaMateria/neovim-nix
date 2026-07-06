# run/

Launcher scripts for each Neovim flavor defined in this flake.

## Why these scripts exist

Each flavor (web, rust, python, …) is a Nix derivation — a pure, immutable binary
living in the Nix store. A derivation cannot rebuild itself: once built it is frozen
at its store path. It also cannot manage mutable state like result symlinks.

These scripts live *outside* the Nix abstraction on purpose. They are the
meta-level orchestrators that:

1. Launch the Nix-built binary
2. Watch for a rebuild signal from inside Neovim (`,r`)
3. Run `nix build` to produce a new store path
4. Update the `result-{flavor}` symlink
5. Restart Neovim with the fresh binary, restoring the previous session

This is similar in spirit to why a Nix installer cannot itself be a Nix package,
or why a CI runner that executes `nix build` cannot live inside what it builds.

## Usage

```
./run/nvim-web [file ...]
./run/nvim-rust [file ...]
# etc.
```

On first run, if no build exists yet, the script builds the flavor automatically.

To rebuild and restart from within Neovim, press `,r`. The session is saved,
Neovim exits, the flake is rebuilt, and Neovim restarts with the session restored.

Multiple instances of the same flavor can run simultaneously — each gets an
isolated session and rebuild flag based on its shell PID.

## How it works

```
  ┌──────────────────────────────────────────────┐
  │  run/nvim-web  (or nvim-rust, nvim-blog, …)  │
  │  Sets FLAVOR="web", sources _runner.sh        │
  └────────────────────┬─────────────────────────┘
                       │ source
                       ▼
  ┌──────────────────────────────────────────────────────────────┐
  │  run/_runner.sh                                              │
  │                                                              │
  │  INSTANCE_ID=$$   (unique per shell process)                 │
  │  NVIM=result-{FLAVOR}/bin/nvim-{FLAVOR}                      │
  │                                                              │
  │  ┌────────────────────────────────────────────────────────┐  │
  │  │ while true                                             │  │
  │  │                                                        │  │
  │  │  launch $NVIM                                          │  │
  │  │    env: NVIM_INSTANCE_ID, NVIM_FLAVOR                  │  │
  │  │    flag: -S /tmp/nvim-session-{flavor}-{id}.vim        │  │
  │  │         (if session file exists)                       │  │
  │  │                                                        │  │
  │  │  Neovim exits                                          │  │
  │  │         │                                              │  │
  │  │         ├─ rebuild flag present?                       │  │
  │  │         │    YES → nix build #neovim.{FLAVOR}          │  │
  │  │         │               --out-link result-{FLAVOR}     │  │
  │  │         │          → loop (restart with new binary)    │  │
  │  │         │                                              │  │
  │  │         └─ NO → delete session file, exit              │  │
  │  └────────────────────────────────────────────────────────┘  │
  └──────────────────────────────────────────────────────────────┘
                       │ launches
                       ▼
  ┌──────────────────────────────────────────────────────────────┐
  │  result-{FLAVOR}/bin/nvim-{FLAVOR}   (Nix store, immutable)  │
  │                                                              │
  │  ,r keymap (nvim-autocommands.lua):                          │
  │    1. :mksession! /tmp/nvim-session-{flavor}-{id}.vim        │
  │    2. touch /tmp/nvim-rebuild-{flavor}-{id}                  │
  │    3. :qa!                                                   │
  └──────────────────────────────────────────────────────────────┘
```

## Files

| File | Purpose |
|------|---------|
| `_runner.sh` | Shared loop logic — sourced by every flavor script |
| `nvim-base` | Launcher for the `base` flavor |
| `nvim-blog` | Launcher for the `blog` flavor |
| `nvim-c` | Launcher for the `c` flavor |
| `nvim-light` | Launcher for the `light` flavor |
| `nvim-pmwebdev` | Launcher for the `pmwebdev` flavor |
| `nvim-puml` | Launcher for the `puml` flavor |
| `nvim-python` | Launcher for the `python` flavor |
| `nvim-rust` | Launcher for the `rust` flavor |
| `nvim-web` | Launcher for the `web` flavor |

## Result symlinks

Each flavor maintains its own result symlink at the repo root:

```
result-web  → /nix/store/…-nvim-web
result-rust → /nix/store/…-nvim-rust
…
```

These are created automatically on first run and updated on every `,r` rebuild.
They are listed in `.gitignore` (or should be — they are local build artifacts).
