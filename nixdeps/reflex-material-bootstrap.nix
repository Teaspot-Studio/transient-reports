{ mkDerivation, aeson, base, bytestring, containers, data-default
, dependent-map, either, extra, fetchgit, jsaddle, jsaddle-dom
, lens, reflex, reflex-dom, safe, stdenv, text, time
}:
mkDerivation {
  pname = "reflex-material-bootstrap";
  version = "0.2.0.0";
  src = fetchgit {
    url = "https://github.com/hexresearch/reflex-material-bootstrap.git";
    sha256 = "1lwb90z43jhz06d0sgxkrzrjwi3xkvdrkw9z5132vg4mpnpx1br1";
    rev = "d487fe4282448cee2411057bb74c2495b7e43384";
  };
  libraryHaskellDepends = [
    aeson base bytestring containers data-default dependent-map either
    extra jsaddle jsaddle-dom lens reflex reflex-dom safe text time
  ];
  doCheck = false;
  homepage = "https://github.com/hexresearch/reports-manager";
  description = "Frontend library for reactive bootstrap with material skin";
  license = stdenv.lib.licenses.mit;
}
