{pkgs, ...}:
{
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  gtk = {
		enable = true;
		theme = {
			name = "Adwaita-dark";
			package = pkgs.gnome-themes-extra;
		};
	};
	
	qt = {
		enable = true;
    style.name = "adwaita-dark";
		qt6ctSettings.Appearance.style = "adwaita-dark";
		qt5ctSettings.Appearance.style = "adwaita-dark";
	};
}
