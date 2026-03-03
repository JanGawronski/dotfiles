{pkgs, zen-browser, ...}:
{
  graphicalPackages = with pkgs; [
		zen-browser.packages.x86_64-linux.default
  ];
}
