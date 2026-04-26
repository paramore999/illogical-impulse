{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    withRuby = true;
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
}
