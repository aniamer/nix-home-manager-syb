{ pkgs, lib, ... }:

pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "mogelbrod";
    name = "quickopener";
    version = "0.5.0";
    sha256 = "416430bcfaee9554da1f2a0349220ee9c1d5a656fe036809225315a73b8ace57";
  };
  meta = { license = lib.licenses.mit; };
}