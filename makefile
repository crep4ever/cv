######################################################################
# Makefile
#
# Author : Romain Goffe    <romain.goffe@gmail.com>
#          Guillaume Née   <guillaume.nee@greyc.ensicaen.fr>
#          Alexandre Dupas <alexandre.dupas@gmail.com>
# Creation : 20 May 2010
#
# Configuration file for make command
#
######################################################################

######################## Options #####################################
#
# Default builds pdf
# ps : output is a ps file
# pdf : output as pdf
# clean : remove backup files
# cleanps : remove ps files
# cleanpdf : remove pdf files
# cleanall : remove all temp files
#
######################################################################

######################## Dependencies ################################
#
# latex, pdflatex, inkscape, xfig, imagemagick(convert)
#
######################################################################

SOURCES	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
CIBLE = $(SOURCES:%.tex=%)
AUX = $(SOURCES:%.tex=%.aux)

# Figures directory
FIG_DIR = fig

# Sources for image files
FIGSRC_DIR = $(FIG_DIR)/src
GREYSRC_DIR = $(FIG_DIR)/src/grey

# Destination directories for generated images
EPS_DIR = $(FIG_DIR)/eps
PDF_DIR = $(FIG_DIR)/pdf
TEX_DIR = $(FIG_DIR)/tex
GREY_DIR = $(FIG_DIR)/grey

# Various sources files
XFIGS  = $(wildcard $(FIGSRC_DIR)/*.fig)
IMAGES = $(wildcard $(FIGSRC_DIR)/*.gif) \
	$(wildcard $(FIGSRC_DIR)/*.jpg) \
	$(wildcard $(FIGSRC_DIR)/*.eps) \
	$(wildcard $(FIGSRC_DIR)/*.pdf) \
	$(wildcard $(FIGSRC_DIR)/*.svg) 

IMG_GREY = $(wildcard $(GREYSRC_DIR)/*.svg)
IMG_PNG = $(wildcard $(FIGSRC_DIR)/*.png)

EPS  = $(foreach file, $(XFIGS), $(EPS_DIR)/$(basename $(notdir $(file))).eps)
EPS += $(foreach file, $(IMAGES), $(EPS_DIR)/$(basename $(notdir $(file))).eps)
EPS += $(foreach file, $(IMG_PNG), $(EPS_DIR)/$(basename $(notdir $(file))).eps)

PDF  = $(foreach file, $(XFIGS), $(PDF_DIR)/$(basename $(notdir $(file))).pdf)
PDF += $(foreach file, $(IMAGES), $(PDF_DIR)/$(basename $(notdir $(file))).pdf)
PDF += $(foreach file, $(IMG_PNG), $(PDF_DIR)/$(basename $(notdir $(file))).png)

TEX  = $(foreach file, $(XFIGS), $(TEX_DIR)/$(basename $(notdir $(file))).tex) 
TEX += $(wildcard /*.tex)

GREY = $(foreach file, $(IMG_GREY), $(GREY_DIR)/$(basename $(notdir $(file))).pdf) 

############################################################
### Cibles

default: pdf

ps: LATEX = latex
ps: $(CIBLE).ps.gz
#	gv $<

pdf: LATEX = pdflatex
pdf: $(CIBLE).pdf
	evince $<

cleansvg:
	@find . -name "*.svg" -exec inkscape --vacuum-defs {} \;

clean:
	@rm -f $(AUX) $(CIBLE).toc
	@rm -f $(CIBLE).dvi $(CIBLE).out $(CIBLE).log $(CIBLE).nav $(CIBLE).snm
	@rm -f *.aux *.log *.out
	@rm -f $(CIBLE).m*

cleanps: clean
	@rm -f $(EPS) $(TEX) $(CIBLE).ps.gz

cleanpdf: clean
	@rm -f $(PDF) $(GREY) $(CIBLE).pdf paper.pdf

cleanall: cleanps cleanpdf

############################################################

$(AUX): $(SOURCES)
	$(LATEX) $(SOURCES)

$(CIBLE).ps.gz: $(CIBLE).ps
	gzip -f $(CIBLE).ps

$(CIBLE).ps: $(CIBLE).dvi
	dvips $(CIBLE).dvi -o

$(CIBLE).dvi: $(EPS) $(TEX) $(AUX)
	$(LATEX) $(CIBLE).tex

$(CIBLE).pdf: $(PDF) $(GREY) $(TEX) $(AUX)
	$(LATEX) $(CIBLE).tex

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.fig
	fig2dev -L pstex $< $@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.jpg
	convert $< EPS:$@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.png
	convert $< EPS:$@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.gif
	convert $< EPS:$@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.eps
	cp $< $@

$(EPS_DIR)/%.eps: $(FIGSRC_DIR)/%.svg
	inkscape $< --export-eps=$@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.fig
	fig2dev -L pdftex $< $@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.jpg
	convert $< EPDF:$@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.eps
	convert $< EPDF:$@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.pdf
	cp $< $@

$(PDF_DIR)/%.pdf: $(FIGSRC_DIR)/%.svg
	inkscape $< --export-pdf=$@

$(GREY_DIR)/%.pdf: $(GREYSRC_DIR)/%.svg
	inkscape $< --export-pdf=$@

$(PDF_DIR)/%.png: $(FIGSRC_DIR)/%.png
	cp $< $@

$(TEX_DIR)/%.tex: $(FIGSRC_DIR)/%.fig
	fig2dev -L pdftex_t -p $(*F) $< $@
