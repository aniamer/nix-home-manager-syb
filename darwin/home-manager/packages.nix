{ pkgs }:

let
  # pkgsMaster = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/master.tar.gz") {};
  altair = pkgs.callPackage ./packages/altair.nix { };
  # appLauncher = pkgs.callPackage ./packages/app.nix {};
  kubent = pkgs.callPackage ./packages/kubent.nix { };
  obsidian = pkgs.callPackage ./packages/obsidian.nix { };
  syb-cli = pkgs.callPackage ./packages/syb-cli.nix { };
  sloth = pkgs.callPackage ./packages/sloth.nix { };
  adr = pkgs.callPackage ./packages/adr.nix { };
  vlc = pkgs.callPackage ./packages/vlc.nix { };
  tunnelblick = pkgs.callPackage ./packages/tunnelblick.nix { };
  pants = pkgs.callPackage ./packages/pants.nix { };
  vfkit = pkgs.callPackage ./packages/vfkit.nix { };
  fluxcd = pkgs.callPackage ./packages/fluxcd.nix { };
  fonts = with pkgs; [
    fira-code
    monaspace
  ];
  gitTools = with pkgs; [
    delta
    diff-so-fancy
    git-absorb
    git-branchless
    git-open
    git-ps-rs
    graphite-cli
  ];

  nixTools = with pkgs; [ cachix ];

  jsPackages = with pkgs; [
    bun
    deno
    nodejs_latest
  ];

  #coreutils = with oldPkgs; [ coreutils ];

  k8sPackages = with pkgs; [
    # kubenti
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.gke-gcloud-auth-plugin-darwin-arm
      pkgs.google-cloud-sdk.components.bigtable
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
    krew
    kubectl
    kubectx
    kubernetes-helm
    kustomize
    microplane
    podman
    podman-compose
    (pkgs.writeShellScriptBin "docker" "exec -a $0 ${podman}/bin/podman $@")
    qemu
    rancher
    sloth
    terraform
    fluxcd
  ];
  homePackages = with pkgs; [
    # adr
    altair
    # appLauncher
    bash
    bat
    clang-tools
    cmake
    fd
    ffmpeg
    go-outline
    # graalvm19-ce
    grpcurl
    httpie
    jq
    keybase
    # mkchromecast
    ninja
    nixfmt-rfc-style
    python312

    reattach-to-user-namespace
    rectangle
    ripgrep
    ruby
    scala
    slack
    syb-cli
    tree
    tunnelblick
    yarn
    yq-go
    vlc
    grpcui
    zlib
    _1password-gui
    protobuf
    pants
    coursier
    sops
    skopeo
    gnutar
    xz
    pyenv
    clojure
    leiningen
    vfkit
    yamllint
    poetry
    tree-sitter
    tree-sitter-grammars.tree-sitter-python
    goreleaser
    postman
    golangci-lint
    redis
    (lib.hiPrio spicedb-zed)
    prometheus-node-exporter
    zoxide
    gnutar
    iterm2
  ];

in
fonts ++ homePackages ++ gitTools ++ nixTools ++ jsPackages ++ k8sPackages
