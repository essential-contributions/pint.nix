{ rustPlatform
, yurt-src
,
}:
rustPlatform.buildRustPackage rec {
  pname = "yurt";
  version = (builtins.fromTOML (builtins.readFile "${src}/yurtc/Cargo.toml")).package.version;
  src = yurt-src;
  buildNoDefaultFeatures = true;
  doCheck = false; # CI-tested upstream.
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    # FIXME: This enables using `builtins.fetchGit` which uses the user's local
    # `git` (and hence ssh-agent for ssh support). Once the repos are public,
    # this should be removed.
    allowBuiltinFetchGit = true;
  };
}
