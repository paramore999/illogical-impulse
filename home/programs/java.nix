{ pkgs, inputs, ... }:
let
  oldPkgs = inputs.nixpkgs-old.legacyPackages.${pkgs.system};
in
{
  home = {
    packages = with pkgs; [
      (oldPkgs.jdk23)
      gradle
      jetbrains.idea
      nodejs_24
    ];

    sessionVariables = {
      IDEA_JDK = "${oldPkgs.jdk23}";
    };
  };
}
