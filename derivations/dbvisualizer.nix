{
  stdenv,
  lib,
  fetchurl,
  jre,
  makeWrapper,
}:

stdenv.mkDerivation {
  name = "dbvisualizer-11.0.4";

  src = fetchurl {
    url = "https://www.dbvis.com/product_download/dbvis-24.2.1/media/dbvis_linux_24_2_1.tar.gz";
    sha256 = "+Kv0z1LFk17ymT/9Q9elNyfmbPnbrDw3bZb+feBiJ+U=";
  };

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp -a . $out
    ln -sf $out/dbvis $out/bin
    wrapProgram $out/bin/dbvis --set INSTALL4J_JAVA_HOME ${jre}
  '';

  meta = {
    description = "The universal database tool";
    homepage = "https://www.dbvis.com/";
    license = lib.licenses.unfree;
  };
}
