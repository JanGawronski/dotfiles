{
  programs.bash = {
    enable = true;
    profileExtra = ''
    if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec start-dwl
    fi
    '';
  };
}
