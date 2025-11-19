{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        let
          rPackages = with pkgs.rPackages; [
            promises
            future
            languageserver
            shiny_router
            tidyverse
            shiny
            usethis
            rextendr
            devtools
            rsconnect
            DT
            box
            bslib
            plotly
            box_lsp
            box_linters
            RSQLite
          ];
          myPy = pkgs.python3.withPackages (
            p: with p; [
              pandas
              numpy
              matplotlib
            ]
          );
          myR = pkgs.rWrapper.override {
            packages = rPackages;
          };
        in
        {
          packages.default = pkgs.hello;
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              (rstudioWrapper.override { packages = rPackages; })
              myR
              myPy

              cacert
            ];

            shellHook = ''
              	    export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
              	    export CURL_CA_BUNDLE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
              	    '';

          };
        };
      flake = {
      };
    };
}
