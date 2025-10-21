{
  pkgs,
  config,
  ...
}: let
  # builtins.toJSON returns an escaped string given a string
  shrekCopypasta = builtins.toJSON (builtins.readFile ./shrek.txt);
in {
  services.caddy = {
    enable = true;

    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.2.1"];
      hash = "sha256-XwZ0Hkeh2FpQL/fInaSq+/3rCLmQRVvwBM0Y1G1FZNU=";
    };

    globalConfig = ''
      email ricecracker2234@proton.me
      acme_dns cloudflare {$CF_API_TOKEN}
    '';

    virtualHosts."shrek.ricedev.me".extraConfig = ''
      respond ${shrekCopypasta}
    '';
  };

  systemd.services.caddy.serviceConfig.EnvironmentFile = config.age.secrets.cloudflare.path;
}
