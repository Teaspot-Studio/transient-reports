let
  pkgs = import ./pkgs.nix { };
  backend = import ./backend;
  frontend = import ./frontend;
in pkgs.stdenv.mkDerivation {
  name = "transient-reports";
  buildInputs = [
    backend.transient-reports-backend
    frontend.transient-reports-frontend
  ];
  shellHook = ''
    ln -s ${frontend.transient-reports-frontend}/bin/transient-reports-frontend.jsexe ./static
  '';
}
