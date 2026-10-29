{ pkgs, hostname, ... }:
{
  imports = [
    ./../../module/configuration
    ./../../module/configuration/graphical
    ./hardware-configuration.nix
    ./networking.nix
    ./logind.nix
    (import ./../../module/configuration/hostname.nix { inherit hostname; })
  ];

  environment.systemPackages = (import ./../../module/configuration/packages.nix { inherit pkgs; }).basePackages ++ (import ./../../module/configuration/graphical/packages.nix { inherit pkgs; }).graphicalPackages;
}
