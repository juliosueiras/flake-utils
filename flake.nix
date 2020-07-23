
{
  description = "FlakeUtils - A Set of Utilties for Flake/Nix";

  edition = 201909;

  inputs.nixpkgs.url =
    "github:NixOS/nixpkgs/469f14ef0fade3ae4c07e4977638fdf3afc29e08";

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
