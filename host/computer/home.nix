{pkgs, ...}: {
  imports = [
    ./../../module/home
    ./../../module/home/graphical
    ./waybar.nix
  ];
  
  home.packages = (import ./../../module/home/packages.nix { inherit pkgs; }).basePackages ++ (import ./../../module/home/graphical/packages.nix { inherit pkgs; }).graphicalPackages;

  programs.fuzzel.settings.main = {
    dpi-aware = "no";
    font = "monospace:size=14";
  };
}
