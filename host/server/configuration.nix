{ config, lib, pkgs, inputs, hostname, ... }:
{
  imports = [
    ./../../module/configuration
    ./../../module/configuration/ssh.nix
    ./bootloader.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./agenix.nix
    (import ./ngrok.nix { inherit config; })
    (import ./playit.nix { inherit config; })
    (import ./../../module/configuration/hostname.nix { inherit hostname; })
  ];

  environment.systemPackages = (import ./../../module/configuration/packages.nix { inherit pkgs; }).basePackages;
}
