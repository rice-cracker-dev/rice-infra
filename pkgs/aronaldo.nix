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
    rev = "c8995fbf44bf2a599df5722ff608f325047ca2a9";
    hash = "sha256-UdiEcamWT8dweBIhR8FzjUpyrJYwkAZdPtHA2/kFQ2E=";
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
