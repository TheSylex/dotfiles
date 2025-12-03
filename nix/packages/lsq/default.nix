{pkgs}:
pkgs.buildGoModule rec {
  pname = "pet";
  version = "1.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "jrswab";
    repo = "lsq";
    tag = "v${version}";
    hash = "sha256-tYAij49DyRlAgvfE891O6wCLEd26RVk5asdxPr8lf0w=";
  };

  vendorHash = "sha256-YmFE2CDGX/3IdoOdCFZWAsPtiA4sF2SeIb6q9/Fszcc=";
  doCheck = false;
}
