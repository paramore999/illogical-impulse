{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "vscode-wrapped";
      pname = "vscode";
      inherit (pkgs.vscode) version meta;
      paths = [ pkgs.vscode ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/code \
          --add-flags "--gtk-version=4" \
          --add-flags "--ignore-gpu-blocklist" \
          --add-flags "--enable-features=TouchpadOverscrollHistoryNavigation"
      '';
    };
  };
}
