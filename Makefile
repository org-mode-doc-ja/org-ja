# Makefile
#
# Note: This simple tool is available only for Maintainer!
#       Translator shall not call any commands.

TARGET = pdf

TEXI = org.texi
TEXI_JA = org-ja.texi
TEX = ptex
POT = org.pot
PO = org.po
INFO = org
TRANSLATE = po4a-translate
GETTEXTIZE = po4a-gettextize

pdf: $(TEXI_JA) texinfo.tex
	$(TEX) -kanji=utf8 $(TEXI_JA)
	texindex org-ja.??
	$(TEX) -kanji=utf8 $(TEXI_JA)
	texindex org-ja.??
	$(TEX) -kanji=utf8 $(TEXI_JA)
	dvipdfmx org-ja.dvi

info: $(TEXI_JA)
	makeinfo --no-split $(TEXI_JA) -o $(INFO)

texi: $(PO)
	$(TRANSLATE) -f texinfo -m $(TEXI) -M UTF-8 -p $(PO) -l $(TEXI_JA) -k 0

pot: $(TEXI)
	$(GETTEXTIZE) -f texinfo -m $(TEXI) -M UTF-8 -p $(POT)

clean:
	rm -f *.aux *.cp *.cps *.dvi *.fn *.fns *.ky *.kys *.log *.mo *.pg *.pgs *.tmp *.vr *.vrs *.toc *.tp *.tps
