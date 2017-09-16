let
  pkgs = import ../pkgs.nix { };
  # Utilities to modify haskell packages
  justStaticExecutables = pkgs.haskell.lib.justStaticExecutables;
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
  packages = pkgs.haskellPackages.extend (haskellPackagesNew: haskellPackagesOld:
      let
        cabalCall  = name: path: addSrcFilter (haskellPackagesNew.callCabal2nix name path { });
        cabalCallE = name: path: addSrcFilter (justStaticExecutables (haskellPackagesNew.callCabal2nix name path { }));
      in rec {
        transient-reports-api = cabalCall "transient-reports-api" ../api;
        transient-reports-backend = cabalCallE "transient-reports-backend" ./.;
      }
    );
in packages
