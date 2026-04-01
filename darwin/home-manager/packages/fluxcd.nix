{ stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "fluxcd";
  sourceRoot = ".";
  phases = [ "installPhase" "patchPhase" ];

  src = fetchurl {
    url = "https://github.com/fluxcd/flux2/releases/download/v2.2.3/flux_2.2.3_darwin_arm64.tar.gz";
    sha256 = "JSn7XruBDOZmYmI1bik5goKnp2bfTn6VypOkD7gC9FI=";
  };

  installPhase = ''
    mkdir -p $out/bin
    tar -xzf $src -C $out/bin
    chmod +x $out/bin/flux
  '';
}
