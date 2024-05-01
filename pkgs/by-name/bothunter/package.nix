{
  lib,
  fetchFromGitHub,
  fetchpatch,
  scikit-learn-1-2,
}:

let
  python3 = scikit-learn-1-2.python3;
in
scikit-learn-1-2.python3.pkgs.buildPythonApplication rec {
  pname = "bothunter";
  version = "fc42285d3e329bcb7f3122b58eb6a3855e5d7124";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "ahmad-abdellatif";
    repo = "bothunter";
    rev = version;
    hash = "sha256-fHi6GpIZgUJIkfnn70XVDApvD4sMtiyugNxpVunM3xA=";
  };

  patches = [
    (fetchpatch {
      url = "https://github.com/ahmad-abdellatif/BotHunter/pull/3/commits/bff867a4ab52b54ca56138fc218662bb221972f0.patch";
      hash = "sha256-sP0owZMS9Vfl72iVexmVrr+Tip70+fvPI0TUW/AKD/g=";
    })
    (fetchpatch {
      url = "https://github.com/ahmad-abdellatif/BotHunter/pull/3/commits/096e23f2a62ef72da651493c79b5cabbd3039c09.patch";
      hash = "sha256-hZquK2qnyJsJyyXLFlvMfDFmQyg56NUGqdyPr1rh+Ok=";
    })
    (fetchpatch {
      url = "https://github.com/ahmad-abdellatif/BotHunter/pull/3/commits/e2f95516e675b6a9a37423f7517ecbd06d21ad86.patch";
      hash = "sha256-Yz06PH0OhLnRuHtcDdtSTDOUvPxF779Qk1PvVXqAkZ0=";
    })
  ];

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
