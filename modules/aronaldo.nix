{
  self,
  pkgs,
  config,
  ...
}: let
  aronaldo = self.packages.${pkgs.stdenv.hostPlatform.system}.aronaldo;
in {
  systemd.services.aronaldo = {
    enable = true;

    restartTriggers = [aronaldo];

    serviceConfig = {
      ExecStart = "${aronaldo}/bin/aronaldo";
      EnvironmentFile = config.age.secrets.aronaldo.path;
    };
  };
}
