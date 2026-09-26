{pkgs, ...}: {
  graphicalPackages = [
    (import ./clipboard-history.nix { inherit pkgs; }).clipboardHistory
    (import ./session-launcher.nix { inherit pkgs; }).sessionLauncher
    (import ./screenshot.nix { inherit pkgs; }).screenshot
  ];
}
