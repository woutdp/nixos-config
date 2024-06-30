{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation {
  pname = "my-theme";
  version = "53f81e3";
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/my-theme
  '';
  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "48ea0a792711ac0c58cc74f7a03e2e7ba3dc2ac0";
    sha256 = "kXovz813BS+Mtbk6+nNNdnluwp/7V2e3KJLuIfiWRD0=";
  };
}
