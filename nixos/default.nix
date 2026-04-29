{ pkgs, username, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./networking.nix
    ./nix.nix
    ./firefox.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Asia/Almaty";

  nixpkgs.config.allowUnfree = true;

  security.sudo.enable = true;
  security.rtkit.enable = true;

  programs.hyprland.enable = true;

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

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "systemd-journal" "render" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    pciutils
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
  services.fstrim.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${pkgs.greetd}/bin/agreety --cmd Hyprland";
      initial_session = {
        command = "start-hyprland";
        user = username;
      };
    };
  };

  powerManagement.enable = true;

  system.stateVersion = "25.11";
}
