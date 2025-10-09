{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix.url = "github:yaxitech/ragenix";

    ricedev-me.url = "github:rice-cracker-dev/ricedev.me";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    nixos-generators,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];

      flake = {
        nixosConfigurations = {
          netcup = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs;};
            modules = [./hosts/netcup];
          };
        };
      };

      perSystem = {
        pkgs,
        inputs',
        system,
        ...
      }: {
        packages.test-vm = nixos-generators.nixosGenerate {
          inherit system;
          modules = [./hosts/test-vm];
          specialArgs = {inherit inputs;};
          format = "vm";
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nixos-anywhere
            openssl
            inputs'.agenix.packages.default
          ];
        };
      };
    };
}
