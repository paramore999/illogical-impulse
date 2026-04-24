{ ... }:
{
  imports = [
    ./packages.nix
    ./gtk.nix
    ./programs/java.nix
    ./programs/neovim.nix
    ./programs/spicetify.nix
    ./programs/vscode.nix
    ./programs/git.nix
    ./programs/zsh.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "paramore";
    homeDirectory = "/home/paramore";
    stateVersion = "25.11";
  };

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
    illogical-impulse.enable = true;
  };
}
