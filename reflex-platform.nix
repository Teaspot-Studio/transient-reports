import ((import <nixpkgs> {}).fetchFromGitHub {
  owner = "reflex-frp";
  repo = "reflex-platform";
  rev = "1670c5b899658babeda58329d3df6b943cf6aeca";
  sha256  = "0ry3fcxiqr43c5fghsiqn0iarj4gfvk77jkc4na7j7r3k8vjdjh2";
  fetchSubmodules = true;
})
