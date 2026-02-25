{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix.url = "github:yaxitech/ragenix";

    ricedev-me.url = "github:rice-cracker-dev/ricedev.me";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} ({self, ...}: {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      flake = {
        nixosConfigurations = {
          netcup = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs self;};
            modules = [./hosts/netcup];
          };

          test-vm = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs self;};
            modules = [./hosts/test-vm];
          };
        };
      };

      perSystem = {
        pkgs,
        inputs',
        lib,
        ...
      }: {
        packages = lib.packagesFromDirectoryRecursive {
          inherit (pkgs) callPackage;
          directory = ./pkgs;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nixos-anywhere
            openssl
            node2nix
            inputs'.agenix.packages.default
          ];
        };
      };
    });
}
