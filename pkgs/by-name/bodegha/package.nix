{ python3, fetchFromGitHub }:

python3.pkgs.buildPythonApplication rec {
  pname = "BoDeGHa";
  version = "3c987b3a7ede7a736f4cf7971ac3a694ff8d7081";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "mehdigolzadeh";
    repo = "BoDeGHa";
    rev = version;
    hash = "sha256-kiAe9JxX/9Tsqc4jB7z0XY7siVeR6Jx/b26dKO5z3XQ=";
  };

  pythonRelaxDeps = true;

  build-system = [
    python3.pkgs.setuptools
    python3.pkgs.wheel
  ];

  nativeBuildInputs = [ python3.pkgs.pythonRelaxDepsHook ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace-fail "'argparse >= 1.1'," "" \
      --replace-fail "python-levenshtein" "levenshtein"
    substituteInPlace requirement.txt \
      --replace-fail 'argparse >= 1.1' "" \
      --replace-fail "python-levenshtein" "levenshtein"
  '';

  dependencies = with python3.pkgs; [
    levenshtein
    numpy
    pandas
    python-dateutil
    scikit-learn
    setuptools # Setuptools is missing from the dependencies
    tqdm
    urllib3
  ];

  meta = {
    description = "A python tool to predict the identity type in github activities (Human,Bot)";
    homepage = "https://github.com/mehdigolzadeh/BoDeGHa";
    mainProgram = "bodegha";
  };
}
