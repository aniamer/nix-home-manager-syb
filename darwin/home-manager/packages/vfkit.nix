{ stdenv, fetchurl }:

stdenv.mkDerivation {
  name = "vfkit";
  sourceRoot = ".";
  phases = [ "installPhase" "patchPhase" ];

  src = fetchurl {
    url =
      "https://github.com/crc-org/vfkit/releases/download/v0.5.1/vfkit";
    sha256 = "6adf8ab2fb0a3b7e7d778554bdc4ae8a8d9e8f984cebffd4e0c8ff8ea5f08447";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/vfkit
    chmod +x $out/bin/vfkit
  '';
}
