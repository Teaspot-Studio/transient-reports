{ mkDerivation, base, bytestring, containers, directory
, ghcjs-perch, mtl, stdenv, transformers, transient
, transient-universe
}:
mkDerivation {
  pname = "axiom";
  version = "0.4.6";
  sha256 = "0i78rbkzmlfr9454m6ax1wk2f76ks5mc2qp0zqir0ds1x2614rc3";
  libraryHaskellDepends = [
    base bytestring containers directory ghcjs-perch mtl transformers
    transient transient-universe
  ];
  doCheck = false;
  homepage = "https://github.com/transient-haskell/axiom";
  description = "Web EDSL for running in browsers and server nodes using transient";
  license = stdenv.lib.licenses.mit;
}
