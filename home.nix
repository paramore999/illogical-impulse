{ config, pkgs, inputs, ... }:

let
  oldPkgs = inputs.nixpkgs-old.legacyPackages.${pkgs.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  # Necessary for non-NixOS to handle GPU (since home-manager version 25.11)
  targets.genericLinux.enable = true;

  home = {
    username = "paramore";
    homeDirectory = "/home/paramore";
    stateVersion = "25.11";

    file = {};

    packages = with pkgs; [
      # --- Base / GUI Apps ---
      vscode
      thunar
      lxappearance
      telegram-desktop
      librum
      thorium-reader
      nixfmt
      posy-cursors
      google-chrome
      lm_sensors
      zip
      unzip
      dmidecode
      nwg-displays
      nodejs_24
      htop
      jetbrains.idea
      gradle
      oldPkgs.jdk23
      claude-code
    ];
  };

  fonts.fontconfig.enable = true; 

  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk4.colorScheme = "dark";
    gtk4.theme = config.gtk.theme;
  };

  programs = {
    home-manager.enable = true;
    illogical-impulse.enable = true;

    spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
      ];
      enabledSnippets = with spicePkgs.snippets; [
        pointer
      ];
      # theme = spicePkgs.themes.starryNight;
      colorScheme = "Base";
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
        telescope-nvim
        gruvbox-nvim
        lualine-nvim
      ];
      extraPackages = with pkgs; [
        wl-clipboard
      ];
      extraConfig = ''
        set clipboard=unnamedplus
      '';
      initLua = ''
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.cmd("colorscheme gruvbox")

        -- Настройка lualine
        require('lualine').setup()
      '';
    };
  };
  home.sessionVariables = {
    IDEA_JDK = "${oldPkgs.jdk23}";
    # or full path if needed:
    # IDEA_JDK = "${oldPkgs.jdk23}/lib/openjdk";
  };
}
