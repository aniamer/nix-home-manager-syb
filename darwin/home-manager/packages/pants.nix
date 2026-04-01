{ stdenv, fetchurl }:

stdenv.mkDerivation {
  name = "scie-pants";
  sourceRoot = ".";
  phases = [ "installPhase" "patchPhase" ];

  src = fetchurl {
    url =
      "https://github.com/pantsbuild/scie-pants/releases/download/v0.12.0/scie-pants-macos-aarch64";
    sha256 = "d476bc1803a5ee6595ba718a7fb20d3236abfa39cb5da0c43d2b6a13e90adc3e";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/pants
    chmod +x $out/bin/pants
  '';
}
