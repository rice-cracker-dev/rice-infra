{
  inputs,
  pkgs,
  ...
}: let
  ricedev-me = inputs.ricedev-me.packages.${pkgs.system}.default;
in {
  services.caddy.virtualHosts = {
    "ricedev.me".extraConfig = ''
      root * ${ricedev-me}
      encode gzip
      file_server

      header {
          ?Cache-Control "max-age=1800"
      }

      handle_errors {
        rewrite * /{err.status_code}.html
        file_server
      }
    '';

    "www.ricedev.me".extraConfig = "redir https://ricedev.me{uri} permanent";
  };
}
