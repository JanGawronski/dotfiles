{pkgs, ...}: {
  imports = [
    ./../../module/home
    ./../../module/home/graphical
    ./waybar.nix
    ./fuzzel.nix
  ];
  
  home.packages = (import ./../../module/home/packages.nix { inherit pkgs; }).basePackages ++ (import ./../../module/home/graphical/packages.nix { inherit pkgs; }).graphicalPackages;
}
