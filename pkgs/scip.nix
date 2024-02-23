{ cmake
, fetchurl
, gmp
, ipopt
, lib
, readline
, stdenv
, zlib
}:
stdenv.mkDerivation rec {
  pname = "scip";
  version = "8.1.0";

  src = fetchurl {
    url = "https://scipopt.org/download/release/${pname}-${version}.tgz";
    sha256 = "sha256-kxZCf8d4xL8VKYZRMJxuWzNLJ4z+YG0f9WaNULpB9T8=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    gmp
    ipopt
    readline
    zlib
  ];

  cmakeFlags = [
    # To enable this, we need a package for this: https://github.com/lgottwald/PaPILO
    "-DPAPILO=off"
    # To enable this, we need a package for this: https://github.com/scipopt/soplex
    "-DLPS=none"
    # Needs a zimpl package.
    "-DZIMPL=off"
  ];

  doCheck = false;

  meta = {
    description = "A framework for Constraint Integer Programming";
    homepage = "https://scipopt.org/";
    license = lib.licenses.mit;
  };
}

