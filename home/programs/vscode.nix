{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      anthropic.claude-code
    ];
    userSettings = {
      # Use the nix-managed binary instead of the extension's bundled FHS binary,
      # which cannot run on NixOS.
      "claude.executablePath" = "${pkgs.claude-code}/bin/claude";
    };
  };
}
