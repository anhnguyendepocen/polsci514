#!/bin/bash

for f in your_paper.*; do
    if [ ${f#your_paper.} != "tex" -a ${f#your_paper.} != "bib" ]; then
	rm $f
    fi
done

pdflatex your_paper
bibtex your_paper
pdflatex your_paper
pdflatex your_paper
pdflatex your_paper

if [ `uname` = "Darwin" ]; then
    open your_paper.pdf -a Preview
fi

rm your_paper.aux
rm your_paper.bbl
rm your_paper.blg
rm your_paper.out
