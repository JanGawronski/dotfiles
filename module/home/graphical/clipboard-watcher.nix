{ pkgs, ... }:
let
  clipboardWatcher = mimeType: {
    Unit = {
      Description = "Wayland ${mimeType} clipboard history";
      After = [ "dwl-session.target" ];
      PartOf = [ "dwl-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type ${mimeType} --watch ${pkgs.cliphist}/bin/cliphist store";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "dwl-session.target" ];
  };
in
{
  systemd.user.services.cliphist = clipboardWatcher "text";
  systemd.user.services.cliphist-image = clipboardWatcher "image";
}
