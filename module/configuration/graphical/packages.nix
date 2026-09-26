{pkgs, ...}:
{
  graphicalPackages = with pkgs; [
    vmpk
    (mpv.override { scripts = with pkgs.mpvScripts; [ mpris ];})
    krita
    playerctl
    prismlauncher
    cliphist
    fuzzel
    grim
    imv
    slurp
    wl-clipboard
    wlopm
    wlr-randr
    wtype
  ];
}
