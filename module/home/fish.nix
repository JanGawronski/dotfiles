{
  programs.fish = {
    enable = true;
    shellAliases = {
      cd = "z";
      cat = "bat";
      ls = "eza";
      speedtest = "speedtest --bytes";
      df = "df --human-readable";
      du = "du --human-readable --summarize";
      tree = "tree -L 2";
      book = "mpv --no-video --save-position-on-quit";
      music = "mpv --shuffle --loop-playlist --no-video";
      copilot = "nix shell nixpkgs#nodejs -c npx --yes @github/copilot";
    };
    interactiveShellInit = "set -g fish_greeting";
  };
}
