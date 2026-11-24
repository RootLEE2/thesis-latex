# Requires TeX Live with ko.TeX and latexmk.
.PHONY: all clean
all:
	latexmk -xelatex -interaction=nonstopmode -halt-on-error thesis.tex

clean:
	latexmk -c thesis.tex
