{ pkgs, lib, ... }:

# pkgs.vs-codebuildVscodeMarketplaceExtension {
pkgs.vscode-utils.buildVscodeMarketplaceExtension {
  mktplcRef = {
    publisher = "github";
    name = "copilot";
    version = "1.184.844";
    sha256 = "6d51666106195f01c963351062bfce3fbb9f6794ca42900c46c17bb89303bb3f";
  };
  meta = { license = lib.licenses.unfree; };
}
