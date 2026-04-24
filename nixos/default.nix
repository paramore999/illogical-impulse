{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "paramore";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Almaty";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  security.sudo.enable = true;
  security.rtkit.enable = true;

  programs.hyprland.enable = true;
  programs.zsh.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
      icu
      nss
      openssl
      curl
      expat
      glib
      libgcc
    ];
  };

  users.users.paramore = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "render" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    pciutils
    home-manager
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  fonts.packages = with pkgs; [
    rubik
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
  ];

  services.tumbler.enable = true;
  services.geoclue2.enable = true;
  services.upower.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
      initial_session = {
        command = "start-hyprland";
        user = "paramore";
      };
    };
  };

  powerManagement.enable = true;

  system.stateVersion = "25.11";
}
