{
  description = "Illogical Impulse - Home-manager module for end-4's Hyprland dotfiles with QuickShell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # For JDK 23 availability
    nixpkgs-old.url = "github:NixOS/nixpkgs/02edef5b3d4f622d770ef70ddb333d648bb540fa";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { nixpkgs, home-manager, illogical-flake, ... } @ inputs:
  let
    system   = "x86_64-linux";
    username = "paramore";
    hostname = "nixos";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ (import ./overlays/kde-material-you-colors.nix) ];
    };
  in
  {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs username hostname; };
      modules = [ ./nixos ];
    };

    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs username; };
      modules = [
        ./home
        illogical-flake.homeManagerModules.default
      ];
    };
  };
}
