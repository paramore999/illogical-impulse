{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default = {
      userSettings = {
        # Use the nix-managed binary instead of the extension's bundled FHS binary,
        # which cannot run on NixOS.
        "claude.executablePath" = "${pkgs.claude-code}/bin/claude";

        # Nerd Font required for Zsh prompt glyphs (arrows, icons) to render correctly.
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";

        "[markdown]" = {
          "diffEditor.ignoreTrimWhitespace" = true;
        };

        "claudeCode.preferredLocation" = "panel";

        "files.autoSave" = "off";
      };
    };
  };
}
