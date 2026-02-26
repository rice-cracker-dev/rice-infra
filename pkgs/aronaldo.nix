{
  buildNpmPackage,
  fetchFromGitHub,
  makeWrapper,
  nodejs,
}:
buildNpmPackage (final: {
  pname = "aronaldo";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "ruanyouxing";
    repo = "aronaldo";
    rev = "031ca642f2891a21e5c49e67e3d38c3b596d12ec";
    hash = "sha256-FGhQVJMWouBzoXXWoAy+Galg9Lg3snEq3TgoQ5iBEq0=";
  };

  nativeBuildInputs = [makeWrapper];

  dontNpmBuild = true;
  npmDepsHash = "sha256-0sQ9zSTe1HIhqrYEWK7Hxc0YmKKJNNvo4zvB61jJNEg=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = ["--ignore-scripts"];

  NODE_OPTIONS = "--openssl-legacy-provider";

  postInstall = ''
    makeWrapper ${nodejs}/bin/node $out/bin/aronaldo \
      --add-flags "$out/lib/node_modules/aronaldo/index.js"
  '';
})
