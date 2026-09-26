{ pkgs, ... }:
{
  screenshot = pkgs.writeShellApplication {
    name = "dwl-screenshot";
    runtimeInputs = [ pkgs.coreutils pkgs.grim pkgs.slurp pkgs.wl-clipboard ];
    text = ''
      case "''${1:-}" in
        region)
          geometry="$(slurp)"
          grim -g "$geometry" - | wl-copy --type image/png
          ;;
        screen)
          grim - | wl-copy --type image/png
          ;;
        file)
          directory="$HOME/Pictures/Screenshots"
          mkdir -p "$directory"
          grim "$directory/$(date +%Y.%m.%d_%H.%M.%S.%N).png"
          ;;
        *)
          echo "Usage: dwl-screenshot {region|screen|file}" >&2
          exit 2
          ;;
      esac
    '';
  };
}
