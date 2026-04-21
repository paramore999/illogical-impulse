# illogical-impulse

A NixOS [home-manager](https://github.com/nix-community/home-manager) configuration built around [end-4's Hyprland dotfiles](https://github.com/end-4/dots-hyprland) and [QuickShell](https://quickshell.outfoxxed.me/), managed via the [`illogical-flake`](https://github.com/soymou/illogical-flake) module.

## What's included

- **Hyprland + QuickShell** — window manager and shell UI via `illogical-flake`
- **Spicetify** — Spotify with adblock, shuffle, hide podcasts, new releases
- **Neovim** — Treesitter, Telescope, Gruvbox, Lualine
- **VS Code**, **IntelliJ IDEA**, **JDK 23**, **Gradle**, **Node.js**
- **Zsh** — autosuggestions, syntax highlighting, history search
- **GTK dark theming**

## Usage

```bash
# Apply the configuration
nh home switch .

# Dry-run to preview changes
nh home build .

# Update all flake inputs
nix flake update

# Update a single input
nix flake update nixpkgs
```

## Structure

```
flake.nix                          # entry point, inputs, overlay
overlays/
└── kde-material-you-colors.nix   # python-magic hotfix for illogical-flake
home/
├── default.nix                    # user info, imports
├── packages.nix                   # general GUI apps and CLI tools
├── gtk.nix                        # GTK dark theme
└── programs/
    ├── java.nix                   # JDK 23, Gradle, IntelliJ, Node.js
    ├── neovim.nix
    ├── spicetify.nix
    ├── vscode.nix
    ├── git.nix
    └── zsh.nix
```

## Notes

- Requires a non-NixOS Linux system (`targets.genericLinux.enable = true`)
- JDK 23 is pinned to an older nixpkgs commit since it's unavailable in current unstable
- The dotfiles themselves live in [paramore999/dots-hyprland](https://github.com/paramore999/dots-hyprland) and are pulled in as a flake input
