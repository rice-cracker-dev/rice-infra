{
  self,
  pkgs,
  config,
  ...
}: {
  systemd.services.aronaldo = {
    enable = true;

    serviceConfig = {
      ExecStart = "${self.packages.${pkgs.stdenv.hostPlatform.system}.aronaldo}/bin/aronaldo";
      EnvironmentFile = config.age.secrets.aronaldo.path;
    };
  };
}
