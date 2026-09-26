{ pkgs, ... }:
let
  sessionInit = pkgs.writeShellApplication {
    name = "dwl-session-init";
    runtimeInputs = [ pkgs.systemd pkgs.dbus ];
    text = ''
      exec <&-
      if [[ -z "''${WAYLAND_DISPLAY:-}" ]]; then
        echo "dwl did not provide WAYLAND_DISPLAY" >&2
        exit 1
      fi

      systemctl --user import-environment XDG_CURRENT_DESKTOP XDG_SESSION_TYPE WAYLAND_DISPLAY NIXOS_OZONE_WL
      dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP XDG_SESSION_TYPE WAYLAND_DISPLAY NIXOS_OZONE_WL
      if [[ -n "''${DISPLAY:-}" ]]; then
        systemctl --user import-environment DISPLAY
        dbus-update-activation-environment --systemd DISPLAY
      fi
      systemctl --user start dwl-session.target
    '';
  };
in {
  sessionLauncher = pkgs.writeShellApplication {
    name = "start-dwl";
    runtimeInputs = [ pkgs.systemd ];
    text = ''
      if [[ -n "''${WAYLAND_DISPLAY:-}" || -n "''${DISPLAY:-}" ]]; then
        echo "start-dwl must be run from a tty, not an existing graphical session" >&2
        exit 1
      fi
      if [[ -z "''${XDG_RUNTIME_DIR:-}" || ! -d "$XDG_RUNTIME_DIR" ]]; then
        echo "start-dwl requires a logind session with XDG_RUNTIME_DIR" >&2
        exit 1
      fi
      if systemctl --user is-active --quiet graphical-session.target; then
        echo "A graphical user session is still active; log out before starting dwl" >&2
        exit 1
      fi

      export XDG_CURRENT_DESKTOP=dwl XDG_SESSION_TYPE=wayland NIXOS_OZONE_WL=1
      cleanup() {
        local status=0
        systemctl --user stop dwl-session.target graphical-session.target || status=$?
        systemctl --user unset-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE NIXOS_OZONE_WL || status=$?
        if (( status != 0 )); then
          echo "Failed to clean up the dwl user session" >&2
          return "$status"
        fi
      }
      trap cleanup EXIT
      dwl -s "exec ${sessionInit}/bin/dwl-session-init <&-"
    '';
  };
}
