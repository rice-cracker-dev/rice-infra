{config, ...}: {
  services.immich = {
    enable = true;
  };

  services.caddy.virtualHosts."immich.ricedev.me".extraConfig = ''
    reverse_proxy localhost:${builtins.toString config.services.immich.port}
  '';
}
