{ buildGoModule }:

buildGoModule rec {
  pname = "syb-cli";
  version = "6eff538";

  src = builtins.fetchGit {
    url = "git@github.com:soundtrackyourbrand/syb-cli.git";
    rev = "6eff538bdaf9818d24b86390dae3c0e4d01afbb8";
  };

  vendorHash = null;
}
