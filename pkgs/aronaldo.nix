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
    rev = "af8f2280f9ffd5941879e3e5e59c425738cf851c";
    hash = "sha256-/Kt8HB0A8hH6W8vssXu4MG7w0I7eSygjcz38OvqgwN8=";
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
