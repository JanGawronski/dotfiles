{
  programs.alacritty = {
    enable = true;
    settings.font.normal.family = "DejaVu Sans Mono";
    settings.terminal.shell = {
      program = "/usr/bin/env";
      args = [ "fish" ];
    };
  };
}
