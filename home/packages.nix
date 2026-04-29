{ pkgs, ... }:
{
  home.packages = with pkgs; [
    thunar
    lxappearance
    telegram-desktop
    librum
    thorium-reader
    nixfmt
    posy-cursors
    lm_sensors
    zip
    unzip
    dmidecode
    nwg-displays
    htop
    claude-code
    nh
  ];
}
