{pkgs, ...}: {
  imports = [
    ./../../module/home
    ./../../module/home/graphical
  ];
  
  home.packages = (import ./../../module/home/packages.nix { inherit pkgs; }).basePackages ++ (import ./../../module/home/graphical/packages.nix { inherit pkgs; }).graphicalPackages;
}
