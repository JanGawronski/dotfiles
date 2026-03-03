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
    };
    interactiveShellInit = "set -g fish_greeting";
  };
}
