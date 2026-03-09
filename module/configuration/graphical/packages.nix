{pkgs, ...}:
{
  graphicalPackages = with pkgs; [
    xmobar
    dmenu
    vmpk
    mpv
    feh
    krita
    playerctl
    maim
    xdotool
    xclip
    quartus-prime-lite
  ];
}
