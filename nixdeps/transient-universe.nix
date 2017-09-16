{ mkDerivation, base, bytestring, case-insensitive, containers
, directory, filepath, hashable, HTTP, iproute, mtl, network
, network-info, network-uri, process, random, stdenv, stm, TCache
, text, time, transformers, transient, vector, websockets
}:
mkDerivation {
  pname = "transient-universe";
  version = "0.4.6.1";
  sha256 = "1bsx6a0bkys99xwrz78nnd1f8y2ixzcbng0smh1kb6xrac8b1jin";
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base bytestring case-insensitive containers directory filepath
    hashable HTTP iproute mtl network network-info network-uri process
    random stm TCache text time transformers transient vector
    websockets
  ];
  executableHaskellDepends = [
    base bytestring case-insensitive containers directory filepath
    hashable HTTP mtl network network-info network-uri process random
    stm TCache text time transformers transient vector websockets
  ];
  testHaskellDepends = [
    base bytestring case-insensitive containers directory filepath
    hashable HTTP mtl network network-info network-uri process random
    stm TCache text time transformers transient vector websockets
  ];
  doCheck = false;
  homepage = "http://www.fpcomplete.com/user/agocorona";
  description = "Remote execution and map-reduce: distributed computing for Transient";
  license = stdenv.lib.licenses.mit;
}
