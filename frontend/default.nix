let
  reflex-platform = import ./reflex-platform.nix {};
  pkgs = reflex-platform.nixpkgs;

  # Utilities to modify haskell packages
  justBrowserOutput = drv: pkgs.haskell.lib.overrideCabal drv (drv: {
    postFixup = ''
      rm -rf $out/lib $out/nix-support $out/share/doc
      cd $out/bin
      find . -maxdepth 1 -type f ! -name '*.jsexe' -delete
      cd ../..
      '';
  });

  # Filter to exclude garbage from sources of derivations
  filterHaskell = src:
    let f = name: type:
      let base = builtins.baseNameOf name;
      in pkgs.lib.cleanSourceFilter name type &&
        (type != "directory" || base != "dist");
    in builtins.filterSource f src;
  addSrcFilter = drv: pkgs.haskell.lib.overrideCabal drv (drv: {
      src = filterHaskell drv.src;
    });

  # Extend given packages set
  packages = reflex-platform.ghcjs.extend (self: super:
    let
      cabalCall  = name: path: addSrcFilter (self.callCabal2nix name path { });
      cabalCallE = name: path: addSrcFilter (justBrowserOutput (self.callCabal2nix name path { }));
    in rec {
      reflex-material-bootstrap = self.callPackage ../nixdeps/reflex-material-bootstrap.nix {};
      transient-reports-api = cabalCall "transient-reports-api" ../api;
      transient-reports-frontend = cabalCallE "transient-reports-frontend" ./.;
    }
  );
in packages
