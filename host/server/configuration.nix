{ config, lib, pkgs, inputs, hostname, ... }:
{
  imports = [
    ./../../module/configuration
    ./../../module/configuration/ssh.nix
    ./../../module/configuration/bootloader.nix
    ./hardware-configuration.nix
    ./networking.nix
    (import ./../../module/configuration/hostname.nix { inherit hostname; })
  ];

  environment.systemPackages = (import ./../../module/configuration/packages.nix { inherit pkgs; }).basePackages;
}
