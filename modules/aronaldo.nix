{
  self,
  pkgs,
  config,
  ...
}: {
  systemd.services.aronaldo = {
    enable = true;

    serviceConfig = {
      ExecStart = "${pkgs.nodejs}/bin/nodejs ${self.packages.${pkgs.stdenv.hostPlatform.system}.aronaldo}/lib/node_modules/aronaldo/index.js";
      EnvironmentFile = config.age.secrets.aronaldo.path;
    };
  };
}
