let
  pkgs = import ./pkgs.nix { };
  backend = import ./backend.nix;
  frontend = import ./frontend.nix;

in pkgs.stdenv.mkDerivation {
  name = "transient-reports";

  buildInputs = [
    backend.transient-reports
    frontend.transient-reports
  ];

  shellHook = ''
    mkdir -p ./static
    ln -s ${frontend.transient-reports}/bin/transient-reports.jsexe static/out.jsexe
  '';
}
