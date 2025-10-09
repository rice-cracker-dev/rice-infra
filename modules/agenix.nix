{inputs, ...}: {
  imports = [inputs.agenix.nixosModules.default];

  age.secrets = {
    cloudflare.file = ../secrets/cloudflare.age;
    plausible-secret-key.file = ../secrets/plausible-secret-key.age;
  };
}
