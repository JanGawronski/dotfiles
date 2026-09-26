{ pkgs, ... }:
{
  clipboardHistory = pkgs.writeShellApplication {
    name = "dwl-clipboard-history";
    runtimeInputs = [
      pkgs.cliphist
      pkgs.coreutils
      pkgs.fuzzel
      pkgs.gnugrep
      pkgs.wl-clipboard
      pkgs.xdg-utils
    ];
    text = ''
      exec cliphist-fuzzel-img
    '';
  };
}
