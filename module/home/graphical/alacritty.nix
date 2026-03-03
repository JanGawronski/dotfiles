{
  programs.alacritty = {
    enable = true;
    settings.terminal.shell = {
      program = "/usr/bin/env";
      args = [ "fish" ];
    };
  };
}
