{ pkgs, hostname, ... }:
let
  configH =
    if hostname == "computer" then
      pkgs.writeText "dwl-computer-config.h" ''
        #define DWL_COMPUTER_MONITORS
        ${builtins.readFile ./dwl/config.h}
      ''
    else
      ./dwl/config.h;
  unclutterPatch = pkgs.fetchurl {
    url = "https://codeberg.org/dwl/dwl-patches/raw/commit/f93e314dc5b171f593bb8c1786f119f51fbf09c7/patches/unclutter/unclutter.patch";
    hash = "sha256-dzBw27Yxf4QDcjaEyKi3G1XTtf0C+EHeZku6EQo11Ok=";
  };
in
{
  programs.dwl = {
    enable = true;
    package = (pkgs.dwl.override {
      inherit configH;
      enableXWayland = true;
    }).overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./dwl/chords.patch
        unclutterPatch
        ./dwl/workspaces.patch
        ./dwl/behavior.patch
      ];
      postPatch = (old.postPatch or "") + "\n" + ''
        cp ${./dwl/chords.h} chords.h
        cp ${./dwl/workspaces.h} workspaces.h
        cp ${./dwl/behavior.h} behavior.h
      '';
    });
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    wlr.settings.screencast = {
      chooser_type = "dmenu";
      chooser_cmd = "${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt 'Share output> '";
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.dwl = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
    };
  };
}
