{ mkDerivation, atomic-primops, base, bytestring, containers
, directory, mtl, random, stdenv, stm, time, transformers
}:
mkDerivation {
  pname = "transient";
  version = "0.5.9.2";
  sha256 = "0ij3ycc1zln9vnjp66d5mxsgwpzmfswbz018ci6w8m885zdf9dr2";
  libraryHaskellDepends = [
    atomic-primops base bytestring containers directory mtl random stm
    time transformers
  ];
  testHaskellDepends = [
    atomic-primops base bytestring containers directory mtl random stm
    time transformers
  ];
  doCheck = false;
  homepage = "http://www.fpcomplete.com/user/agocorona";
  description = "composing programs with multithreading, events and distributed computing";
  license = stdenv.lib.licenses.mit;
}
