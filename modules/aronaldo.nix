{
  self,
  pkgs,
  config,
  ...
}: let
  inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) aronaldo;
in {
  systemd.services.aronaldo = {
    enable = true;

    restartTriggers = [aronaldo];

    serviceConfig = {
      ExecStart = "${aronaldo}/bin/aronaldo-deploy && ${aronaldo}/bin/aronaldo";
      EnvironmentFile = config.age.secrets.aronaldo.path;
    };
  };
}
