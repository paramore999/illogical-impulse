# Hotfix: kde-material-you-colors is missing python-magic as a propagated dependency,
# which is required by the illogical-flake module.
final: prev: {
  python3 = prev.python3.override {
    packageOverrides = pyFinal: pyPrev: {
      kde-material-you-colors = pyPrev.kde-material-you-colors.overridePythonAttrs (old: {
        propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [ pyFinal.python-magic ];
      });
    };
  };
  kde-material-you-colors = final.python3.pkgs.kde-material-you-colors;
}
