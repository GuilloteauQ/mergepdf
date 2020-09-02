{ pkgs ? import <nixpkgs> {} }:
with pkgs;
let
  version = "1.0";
in {
  mergepdf = stdenv.mkDerivation {
    name = "mergepdf-${version}";
    src = fetchTarball("https://github.com/GuilloteauQ/mergepdf/tarball/master");
    buildInputs = [
      stdenv
	  makeWrapper
    ];
    installPhase = ''
      mkdir $out
      mkdir $out/bin
      cp merge_pdf.sh $out
 	  makeWrapper $out/merge_pdf.sh $out/bin/mergepdf --set PATH ${stdenv.lib.makeBinPath [ texlive.combined.scheme-basic ]}
    '';
  };
}
