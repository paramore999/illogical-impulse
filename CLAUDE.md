# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A NixOS **home-manager** configuration for a single user (`paramore`) that brings together:
- **end-4's Hyprland dotfiles** via the `illogical-flake` module (Hyprland window manager + QuickShell UI)
- **Spicetify** for Spotify customization
- Personal package selection and program configuration

The actual Hyprland/QuickShell dotfiles live in a separate repo ([paramore999/dots-hyprland](https://github.com/paramore999/dots-hyprland)) and are pulled in as a flake input.

## Key Commands

```bash
# Apply the home-manager configuration (preferred: better diff output)
nh home switch .

# Or with plain home-manager
home-manager switch --flake .#paramore

# Update all flake inputs to latest
nix flake update

# Update a single input (e.g., just nixpkgs)
nix flake update nixpkgs

# Check what the flake exposes
nix flake show

# Dry-run to see what would change
nh home build .
```

## Architecture

### File structure

- **`flake.nix`** — Entry point. Declares all external inputs, sets up the nixpkgs overlay (hotfix for `kde-material-you-colors` needing `python-magic`), and wires together the home-manager configuration from `./home` + `illogical-flake.homeManagerModules.default`.
- **`overlays/kde-material-you-colors.nix`** — Patches `kde-material-you-colors` to include `python-magic` as a propagated dependency.
- **`home/default.nix`** — Top-level home-manager module: user info, fonts, and imports all sub-modules.
- **`home/packages.nix`** — General GUI apps and CLI tools.
- **`home/gtk.nix`** — GTK dark theming.
- **`home/programs/java.nix`** — JDK 23 (from pinned nixpkgs), Gradle, IntelliJ IDEA, Node.js, and `IDEA_JDK` session variable.
- **`home/programs/neovim.nix`** — Neovim with Treesitter, Telescope, Gruvbox, Lualine.
- **`home/programs/spicetify.nix`** — Spotify customization (adblock, hidePodcasts, shuffle, newReleases).
- **`home/programs/vscode.nix`** — VS Code via `programs.vscode`.
- **`home/programs/git.nix`** — Git identity, default branch, and push config.
- **`home/programs/zsh.nix`** — Zsh with autosuggestions, syntax highlighting, and history settings.

### Flake inputs

| Input | Purpose |
|---|---|
| `nixpkgs` | nixos-unstable — primary package source |
| `nixpkgs-old` | Pinned nixpkgs for JDK 23 (and `IDEA_JDK` env var) |
| `home-manager` | Follows `nixpkgs` |
| `dotfiles` | paramore999/dots-hyprland (non-flake, submodules enabled) |
| `illogical-flake` | soymou/illogical-flake — provides `homeManagerModules.default` which enables the Hyprland/QuickShell setup; takes `dotfiles` as input |
| `spicetify-nix` | Spotify theming via `programs.spicetify` |

### Notable details

- `targets.genericLinux.enable = true` — required for non-NixOS systems to handle GPU correctly (home-manager ≥ 25.11).
- JDK 23 is sourced from the pinned `nixpkgs-old` input because it's not available in current unstable; `IDEA_JDK` session variable points to it for IntelliJ IDEA.
- The python overlay in `flake.nix` patches `kde-material-you-colors` to include `python-magic` as a propagated dependency — needed by the illogical-flake module.
- Spicetify uses the stock `Base` color scheme (no custom theme applied).
