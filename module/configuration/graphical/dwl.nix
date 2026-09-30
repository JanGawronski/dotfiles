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
  touchInputPatchSource = pkgs.fetchurl {
    url = "https://codeberg.org/dwl/dwl-patches/raw/commit/93435f5ced398af7316748e7681be33909ce0397/patches/touch-input/touch-input-0.9.patch";
    hash = "sha256-NNVkrq6n2pWPemiGknnkeAep3JxUz8Dm713zinUFU9I=";
  };
  touchInputPatch = pkgs.runCommand "touch-input-0.9.patch" { } ''
    sed \
      -e 's/@@ -359,6 +368,10 @@/@@ -359,4 +366,8 @@/' \
      -e '/^ static void toggletag(const Arg \*arg);$/d' \
      -e '/^ static void toggleview(const Arg \*arg);$/d' \
      ${touchInputPatchSource} > "$out"
  '';
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
        touchInputPatch
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
