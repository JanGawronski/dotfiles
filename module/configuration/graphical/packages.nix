{pkgs, ...}:
{
  graphicalPackages = with pkgs; [
    xmobar
    dmenu
    vmpk
    (mpv.override { scripts = with pkgs.mpvScripts; [ mpris ];})
    feh
    krita
    playerctl
    maim
    xdotool
    xclip
    prismlauncher
  ];
}
