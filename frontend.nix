let
  #pkgs = import ./pkgs.nix { };
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
      ghcjs-perch = self.callPackage ./nixdeps/ghcjs-perch.nix {};
      transient = self.callPackage ./nixdeps/transient.nix {};
      transient-universe = self.callPackage ./nixdeps/transient-universe.nix {};
      axiom = self.callPackage ./nixdeps/axiom.nix {};
      transient-reports = cabalCallE "transient-reports" ./.;
    }
  );
in packages
