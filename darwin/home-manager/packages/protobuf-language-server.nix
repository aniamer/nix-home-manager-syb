{ buildGoModule }:

buildGoModule rec {
  pname = "protobuf-language-server";
  version = "0.1.2";

  src = builtins.fetchGit {
    url = "git@github.com:lasorda/protobuf-language-server.git";
    rev="61a4b7f33cab039d6bf895bd31cd6bf2abac3f06";
  };

  subPackages = [
    "components"
    "go-lsp/lsp/defines"
    "go-lsp/lsp"
    "go-lsp/example"
    "go-lsp/jsonrpc"
    "go-lsp/logs"
    "proto/parser"
    "proto/types"
    "proto/view"
    "proto/view/fs"
  ];

  vendorHash = "sha256-4nTpKBe7ekJsfQf+P6edT/9Vp2SBYbKz1ITawD3bhkI=";


}
