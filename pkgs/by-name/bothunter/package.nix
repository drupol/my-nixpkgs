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
  version = "b8b8e7b2f283ae4e4758b402620e691694e6257a";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "ahmad-abdellatif";
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
