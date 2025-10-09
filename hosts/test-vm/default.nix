{
  lib,
  inputs,
  modulesPath,
  config,
  ...
}: let
  forwardGuestPort = port: {
    from = "guest";
    guest.port = port;
    guest.address = "10.0.2.10";
    host.port = port;
    host.address = "127.0.0.1";
  };
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    "${inputs.self}/modules"
  ];

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # this config is only used for testing lol
  users.users.root.initialPassword = "123";

  networking.firewall.enable = lib.mkForce false;
  services.caddy.enable = lib.mkForce false;

  virtualisation.diskSize = 1024 * 32;
  virtualisation.memorySize = 1024 * 4;
  virtualisation.forwardPorts = [
    (forwardGuestPort config.services.immich.port)
    (forwardGuestPort config.services.plausible.server.port)
  ];

  system.stateVersion = "25.11";
}
