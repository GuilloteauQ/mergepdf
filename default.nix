{ pkgs ? import <nixpkgs> {} }:
with pkgs;
let
  version = "1.0";
in {
  pdfmerger = stdenv.mkDerivation {
    name = "mergepdf-${version}";
    src = ./.;
    buildInputs = [
      stdenv
	  makeWrapper
    ];
    installPhase = ''
      mkdir $out
      cp pdf_merger.sh $out
 	  makeWrapper $out/merge_pdf.sh $out/mergepdf --set PATH ${stdenv.lib.makeBinPath [ texlive.combined.scheme-basic ]}
    '';
  };
}
