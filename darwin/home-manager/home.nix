{ config, pkgs, lib, ... }:

let
  vscode-monochrome = pkgs.callPackage ./vscode/monochrome.nix { };
  vscode-monochrome-dark = pkgs.callPackage ./vscode/monochrome-dark.nix { };
  vscode-copilot = pkgs.callPackage ./vscode/copilot.nix { };
  vscode-quickopener = pkgs.callPackage ./vscode/quickopener.nix { };
  externalPackages = import ./packages.nix { inherit pkgs ; };
  allPackages = externalPackages ;
in {
  nixpkgs = {
    overlays = [(final: prev: {
      inetutils = prev.inetutils.overrideAttrs (oldAttrs: rec {
        version = "2.6";
        src = prev.fetchurl {
          url = "mirror://gnu/inetutils/inetutils-${version}.tar.xz";
          hash = "sha256-aL7b/q9z99hr4qfZm8+9QJPYKfUncIk5Ga4XTAsjV8o=";
        };
      });
    })];

    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      allowBroken = true;
      packageOverrides = pkgs: {
         nur = import (builtins.fetchTarball
           "https://github.com/nix-community/NUR/archive/master.tar.gz") {
             inherit pkgs;
           };
       };
    };
  };

  fonts = { fontconfig = { enable = true; }; };

  programs = {
    alacritty = import ./alacritty.nix;

    direnv = {
      enable = true;

      nix-direnv = { enable = true; };
    };

    eza = {
      enable = true;
    };

    firefox = {
      enable = true;
      #package = firefox-darwin;
      # extraPolicies = {
      #   DisableFirefoxStudies = true;
      #   DisablePocket = true;
      #   DisableTelemetry = true;
      #   DisableFirefoxAccounts = true;
      #   FirefoxHome = {
      #     Pocket = false;
      #     Snippets = false;
      #   };
      #   UserMessaging = {
      #     ExtensionRecommendations = false;
      #     SkipOnboarding = true;
      #   };
      # };
      profiles = {
        ani = {
          id = 0;
          settings = {
            "app.update.auto" = true;
            "signon.rememberSignons" = false;
            "browser.casting.enabled" = true;
          };
           extensions = with pkgs.nur.repos.rycee.firefox-addons; [
             ublock-origin
             unpaywall
             reddit-enhancement-suite
             react-devtools
           ];
        };
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    gh = { enable = true; };

    git = import ./git.nix { inherit pkgs; };

    go = { enable = true; };

    gpg = { enable = true; };

    home-manager = { enable = true; };

    irssi = {
      enable = true;
      networks = {
        oftc = {
          nick = "ani";
          server = {
            address = "irc.oftc.net";
            port = 6697;
            autoConnect = true;
          };
          channels = {
            nixos.autoJoin = true;
            home-manager.autoJoin = true;
          };
        };
      };
    };

    java = {
      enable = true;
      # package = pkgs.graalvm19-ce;
    };

    neovim = import ./neovim.nix { vimPlugins = pkgs.vimPlugins; };
    tmux = import ./tmux.nix { inherit pkgs; };

    sbt = { enable = true; };

    ssh = {
      enable = true;
      extraConfig = ''
        IgnoreUnknown UseKeychain
        AddKeysToAgent yes
        UseKeychain yes
        IdentityFile ~/.ssh/id_ed25519
      '';
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$cmd_duration"
          "$character"
        ];
        directory = { style = "blue"; };
        scan_timeout = 10;
        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vimcmd_symbol = "[❮](green)";
        };
        git_branch = {
          format = "[$branch]($style)";
          style = "bright-black";
        };
        git_status = {
          format =
            "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "​";
          untracked = "​";
          modified = "​";
          staged = "​";
          renamed = "​";
          deleted = "​";
          stashed = "≡";
        };
        git_state = {
          format = lib.concatStrings
            [ "([$state( $progress_current/$progress_total)]($style)) " ];
          style = "bright-black";
        };
        cmd_duration = {
          format = "[$duration]($style) ";
          style = "yellow";
        };
      };
    };

    vscode = {
      enable = true;
      mutableExtensionsDir = true;
      profiles = {
        default = {
          extensions = with pkgs.vscode-extensions;
            [
              # vscode-monochrome
              brettm12345.nixfmt-vscode
              # github.copilot
              graphql.vscode-graphql
              graphql.vscode-graphql-syntax
              vscode-copilot
              golang.go
              hashicorp.terraform
              jnoortheen.nix-ide
              scala-lang.scala
              scalameta.metals
              vscode-monochrome-dark
              vscode-quickopener
              vscodevim.vim
              vspacecode.vspacecode
              vspacecode.whichkey
              zxh404.vscode-proto3
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
              name = "apc-extension";
              publisher = "drcika";
              version = "0.3.9";
              sha256 =
                "54c508086bc0156ac6fee2f768628d508b75011a2f73ce13c648e04a45eea0c1";
            }];

            userSettings = {
              "[nix]"."editor.tabSize" = 2;
              "nix.enableLanguageServer" = true;
              "vim.easymotion" = true;
              "vim.useSystemClipboard" = true;
              "vim.normalModeKeyBindingsNonRecursive" = [
                {
                  "before" = [ "<space>" ];
                  "commands" = [ "vspacecode.space" ];
                }
                {
                  "before" = [ "," ];
                  "commands" = [
                    "vspacecode.space"
                    {
                      "command" = "whichkey.triggerKey";
                      "args" = "m";
                    }
                  ];
                }
              ];
              "vim.visualModeKeyBindingsNonRecursive" = [
                {
                  "before" = [ "<space>" ];
                  "commands" = [ "vspacecode.space" ];
                }
                {
                  "before" = [ "," ];
                  "commands" = [
                    "vspacecode.space"
                    {
                      "command" = "whichkey.triggerKey";
                      "args" = "m";
                    }
                  ];
                }
              ];

              "files.watcherExclude" = {
                "**/.bloop" = true;
                "**/.metals" = true;
                "**/.ammonite" = true;
              };

              "editor.fontFamily" = "'Monaspace Neon', monaspace";
              "editor.fontSize" = 15;
              "editor.fontLigatures" = true;
              "editor.formatOnSave" = true;
              "editor.bracketPairColorization.enabled" = false;
              "editor.inlineSuggest.enabled" = true;
              "editor.minimap.enabled" = false;
              "editor.inlayHints.enabled" = "on";
              "editor.inlayHints.fontSize" = 11;
              "editor.tokenColorCustomizations" = { };

              "metals.suggestLatestUpgrade" = true;

              "github.copilot.enable" = {
                "*" = true;
                "yaml" = true;
                "zaml" = true;
                "plaintext" = false;
                "markdown" = false;
                "scala" = true;
                "toml" = true;
                "nix" = true;
              };

              "window.zoomLevel" = 1;
              "workbench.colorTheme" = "Monochrome Dark";
              "workbench.preferredDarkColorTheme" = "Monochrome Dark";
              "workbench.colorCustomizations" = {
                "[Monochrome Dark]" = {
                  "editorInlayHint.foreground" = "#606060";
                  "editorInlayHint.background" = "#1a1a1a";
                  "editorInlayHint.typeForeground" = "#606060";
                  "editorInlayHint.parameterForeground" = "#606060";
                };
              };

              "apc.activityBar" = {
                "position" = "bottom";
                "hideSettings" = true;
                "size" = 20;
              };

              "apc.statusBar" = {
                "position" = "editor-bottom";
                "height" = 22;
                "fontSize" = 12;
              };

              "apc.electron" = {
                "titleBarStyle" = "hiddenInset";
                "trafficLightPosition" = {
                  "x" = 8;
                  "y" = 10;
                };
              };

              "apc.header" = {
                "height" = 34;
                "fontSize" = 14;
              };

              "apc.listRow" = {
                "height" = 21;
                "fontSize" = 13;
              };
            };
        };
      };
    };

    zsh = import ./zsh.nix {
      inherit pkgs;
      inherit config;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home = {
    username = "ani";
    homeDirectory = "/Users/ani";
    stateVersion = "25.11";
    packages = allPackages;
    sessionVariables = {
      EDITOR = "nvim";
      SHELL = "$HOME/.nix-profile/bin/zsh";
    };

    file = {
      "${config.xdg.configHome}/git-ps" = {
        source = ./git-ps;
        recursive = true;
      };
    };
  };
}
