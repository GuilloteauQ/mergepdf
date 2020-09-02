

OUTPUT_FILENAME=out.tex

PDF_FILES=()

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -o|--output)
    PDF_FILENAME="$2"
    OUTPUT_FILENAME="$(basename ${PDF_FILENAME} pdf)tex"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    PDF_FILES+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done

echo "$PDF_FILES"

echo "\\documentclass{article}" > ${OUTPUT_FILENAME}
echo "\\usepackage{pdfpages}" >> ${OUTPUT_FILENAME}
echo "\\begin{document}" >> ${OUTPUT_FILENAME}

for pdf_file in "${PDF_FILES[@]}"
do
	echo "\\includepdf[pages=-]{$pdf_file}" >> ${OUTPUT_FILENAME}
done

echo "\\end{document}" >> ${OUTPUT_FILENAME}

pdflatex ${OUTPUT_FILENAME} -o ${PDF_FILENAME}
