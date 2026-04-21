{ config, ... }:
{
  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk4.colorScheme = "dark";
    gtk4.theme = config.gtk.theme;
  };
}
