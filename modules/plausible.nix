{config, ...}: let
  baseUrl = "analytics.ricedev.me";
in {
  services.plausible = {
    enable = true;
    server = {
      baseUrl = "https://${baseUrl}";
      secretKeybaseFile = config.age.secrets.plausible-secret-key.path;
      disableRegistration = true;
    };
  };

  services.caddy.virtualHosts.${baseUrl}.extraConfig = ''
    reverse_proxy localhost:${builtins.toString config.services.plausible.server.port}
  '';
}
