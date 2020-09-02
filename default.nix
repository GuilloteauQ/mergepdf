{ pkgs ? import <nixpkgs> {} }:
with pkgs;
let
  version = "1.0";
in {
  pdfmerger = stdenv.mkDerivation {
    name = "mergepdf-${version}";
    src = fetchTarball("https://github.com/GuilloteauQ/mergepdf/tarball/master");
    buildInputs = [
      stdenv
	  makeWrapper
    ];
    installPhase = ''
      mkdir $out
      cp merge_pdf.sh $out
 	  makeWrapper $out/merge_pdf.sh $out/mergepdf --set PATH ${stdenv.lib.makeBinPath [ texlive.combined.scheme-basic ]}
    '';
  };
}
