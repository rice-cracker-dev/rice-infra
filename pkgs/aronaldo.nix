{
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage (final: {
  pname = "aronaldo";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "ruanyouxing";
    repo = "aronaldo";
    rev = "5b6e8b42b6d53d0625345f4e1603e5b33f99d261";
    hash = "sha256-s2ahiwVmzGRT+ezV36LRLB5CIM6e67YBH7WBU8Aovv0=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-0sQ9zSTe1HIhqrYEWK7Hxc0YmKKJNNvo4zvB61jJNEg=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = ["--ignore-scripts"];

  NODE_OPTIONS = "--openssl-legacy-provider";
})
