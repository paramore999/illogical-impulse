{
  description = "Illogical Impulse - Home-manager module for end-4's Hyprland dotfiles with QuickShell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nixpkgs-old = {
      url = "github:NixOS/nixpkgs/02edef5b3d4f622d770ef70ddb333d648bb540fa";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Your custom dotfiles
    dotfiles = {
      url = "git+https://github.com/paramore999/dots-hyprland?submodules=1";
      flake = false;
    };

    illogical-flake = {
      url = "github:soymou/illogical-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dotfiles.follows = "dotfiles";
    };
  };

  outputs = { nixpkgs, home-manager, illogical-flake, ... } @ inputs: {
    # my additions
    homeConfigurations.paramore = home-manager.lib.homeManagerConfiguration {
      # pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;        };
        # This "hotfixes" the broken package
        overlays = [
          (final: prev: {
            python3 = prev.python3.override {
              packageOverrides = pyFinal: pyPrev: {
                kde-material-you-colors = pyPrev.kde-material-you-colors.overridePythonAttrs (old: {
                  propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [ pyFinal.python-magic ];
                });
              };
            };
            # Also override the top-level alias if necessary
            kde-material-you-colors = final.python3.pkgs.kde-material-you-colors;
          })
        ];
      };

      extraSpecialArgs = { inherit inputs; }; 

      modules = [
        ./home.nix
        illogical-flake.homeManagerModules.default
         {
          programs.illogical-impulse.enable = true;
          programs.home-manager.enable = true;
         }
      ];
    };
  };
}
