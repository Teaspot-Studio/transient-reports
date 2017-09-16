let
  pkgs = import ./pkgs.nix { };
  backend = import ./backend.nix;
  frontend = import ./frontend.nix;

# Merge all packages into single derivative to place in single result symlink
in pkgs.buildEnv {
  name = "transient-reports";
  paths = [
    backend.transient-reports
    frontend.transient-reports
  ];
}
