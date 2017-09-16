let
  pkgs = import ./pkgs.nix { };
  backend = import ./backend;
  frontend = import ./frontend;

# Merge all packages into single derivative to place in single result symlink
in pkgs.buildEnv {
  name = "transient-reports";
  paths = [
    backend.transient-reports-backend
    frontend.transient-reports-frontend
  ];
}
