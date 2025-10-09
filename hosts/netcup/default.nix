{
  inputs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
    ./disko-config.nix
    ./hardware-configuration.nix
    "${inputs.self}/modules"
  ];

  system.stateVersion = "25.11";
}
