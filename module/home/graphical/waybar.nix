{ pkgs, ... }:
let
  micStatus = pkgs.writeShellScript "dwl-mic-status" ''
    volume="$(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SOURCE@)" || exit $?
    case "$volume" in
      *MUTED*) echo "" ;;
      *) echo "Mic unmuted |" ;;
    esac
  '';
  swapStatus = pkgs.writeShellScript "dwl-swap-status" ''
    ${pkgs.gawk}/bin/awk '/^SwapTotal:/ { total = $2 } /^SwapFree:/ { free = $2 } END { if (total == 0) print "Swap: 0% |"; else printf "Swap: %.0f%% |\n", (total - free) * 100 / total }' /proc/meminfo
  '';  
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "dwl-session.target" ];
    };
    settings.mainBar = {
      layer = "top";
      exclusive = false;
      start_hidden = true;
      position = "top";
      height = 24;
      spacing = 8;
      modules-right = [ "custom/mic" "cpu" "memory" "custom/swap" "clock" ];
      "custom/mic" = {
        exec = "${micStatus}";
        interval = 1;
        format = "{}";
      };
      cpu = {
        interval = 10;
        format = "CPU: {usage}% |";
      };
      memory = {
        interval = 10;
        format = "Mem: {percentage}% |";
      };
      "custom/swap" = {
        exec = "${swapStatus}";
        interval = 10;
        format = "{}";
      };
      clock = {
        interval = 1;
        format = "{:%a %Y.%m.%d %H:%M:%S}";
      };
    };
    style = ''
      * {
        border: none;
        font-family: "FiraCode Nerd Font Mono";
        font-size: 13px;
      }
      window#waybar {
        background: #000000;
        color: #ffffff;
      }
    '';
  };
}
