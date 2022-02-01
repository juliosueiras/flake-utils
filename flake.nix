
{
  description = "FlakeUtils - A Set of Utilties for Flake/Nix";

  inputs.nixpkgs.url =
    "github:NixOS/nixpkgs/0f316e4d72daed659233817ffe52bf08e081b5de";

    outputs = { self, nixpkgs }: let
      pkgs = (import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
      });
    in {
      lib = {
        makeCheckTest = { name, packageInputs, checkScript, ... }: pkgs.stdenv.mkDerivation {
          inherit name;

          phases = ["checkPhase" "installPhase"];

          src = null;

          doCheck = true;

          buildInputs = packageInputs;

          checkPhase = checkScript;

          installPhase = ''
            mkdir $out
          '';
        };
      };
    };
  }
