{ mkDerivation, base, stdenv, transformers, ghcjs-base }:
mkDerivation {
  pname = "ghcjs-perch";
  version = "0.3.3.2";
  sha256 = "1ng6wpx6kp8rxmxwf0ns0q0jas2gl2s2mv1dlq59xbsikdly3km7";
  libraryHaskellDepends = [ base transformers ghcjs-base ];
  doCheck = false;
  description = "GHCJS version of Perch library";
  license = stdenv.lib.licenses.mit;
}
