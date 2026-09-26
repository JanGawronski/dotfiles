{
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
  };
}
