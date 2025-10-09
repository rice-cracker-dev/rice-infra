{
  imports = [
    ./agenix.nix
    ./caddy.nix
    ./immich.nix
    ./networking.nix
    ./openssh.nix
    ./plausible.nix
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };
}
