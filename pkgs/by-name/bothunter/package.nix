{
  lib,
  fetchFromGitHub,
  scikit-learn-1-2,
}:

let
  python3 = scikit-learn-1-2.python3;
in
scikit-learn-1-2.python3.pkgs.buildPythonApplication rec {
  pname = "bothunter";
  version = "e2f95516e675b6a9a37423f7517ecbd06d21ad86";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "drupol";
    repo = "bothunter";
    rev = version;
    hash = "sha256-rH3juXroZM8XQhRlnFms3oM0xbRKPKHNlSx7IjuJ/9U=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    joblib
    numpy
    pygithub
    datetime
    scikit-learn
    statistics
    pandas
  ];

  postInstall = ''
    cp random_forest.joblib $out/${python3.sitePackages}/
  '';

  meta = {
    homepage = "https://github.com/ahmad-abdellatif/BotHunter";
    license = lib.licenses.asl20;
    mainProgram = "bothunter";
  };
}
