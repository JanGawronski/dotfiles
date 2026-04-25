{pkgs, ...}:
{
  dconf.settings."org.gnome.desktop.interface".color-scheme = "prefer-dark";

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.theme = null;
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };
}
