 { stdenv, lib, fetchurl, undmg }:

 stdenv.mkDerivation rec {
   pname = "tunnelblick";
   version = "3.8.8g";
    
   buildInputs = [ undmg ];
   sourceRoot = ".";
   phases = ["unpackPhase" "installPhase"];
   installPhase = ''
     mkdir -p "$out/Applications"
     cp -r Tunnelblick.app "$out/Applications/Tunnelblick.app"
   '';
 
   src = fetchurl {
     name = "Tunnelblick_${version}_build_5779.dmg";
     url = "https://tunnelblick.net/iprelease/Tunnelblick_3.8.8g_build_5779.3.dmg";
     sha256 = "b3310a7435543c3047fd8500297fde7825f5ceb89e194f6adec0a3ee773d669d";
   };
 
   meta = with lib; {
     description = "Tunnelblick VPN";
     homepage = "https://tunnelblick.net/";
     maintainers = [ maintainers.frekw ];
     platforms = platforms.darwin;
   };  
 }