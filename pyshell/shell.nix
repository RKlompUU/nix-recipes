{ projectRoot ? ".", pkgs ? import <nixpkgs> {} }:
let
in pkgs.mkShell {
  venvDir = "${projectRoot}/.venv";
  buildInputs = with pkgs; [
    python3Packages.python
    python3Packages.venvShellHook
  ];

  nativeBuildInputs = with pkgs; [
    pkg-config
  ];

  env = {
    PROJECT_ROOT = projectRoot;
  };

  postShellHook = ''
    cd $PROJECT_ROOT

    unset SOURCE_DATE_EPOCH
    pip install -r ${projectRoot}/requirements.txt
  '';
}
