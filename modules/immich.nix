{config, ...}: {
  services.immich = {
    enable = true;
  };

  services.caddy.virtualHosts."immich.ricedev.me".extraConfig = ''
    request_body {
      max_size 50000MB
    }

    reverse_proxy localhost:${builtins.toString config.services.immich.port}
  '';
}
