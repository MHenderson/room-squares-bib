PROJECT = room-squares-bib
VERSION = 0.1.0
SUBFOLDER = Combinatorics/Room\ Squares

RELEASE_INPUT = src/$(PROJECT).tex src/*.tex
RELEASE_OUTDIR = ${RELEASE_BUILD_FOLDER}/$(SUBFOLDER)
RELEASE_OUTPUT = $(RELEASE_OUTDIR)/$(PROJECT).pdf

DRAFT_INPUT = src/$(PROJECT)-draft.tex src/*.tex
DRAFT_OUTDIR = ${DRAFT_BUILD_FOLDER}/$(SUBFOLDER)
DRAFT_OUTPUT = $(DRAFT_OUTDIR)/$(PROJECT)-draft.pdf

.PHONY: all draft pdf watch clean

all: draft

draft: $(DRAFT_OUTPUT)

pdf: $(RELEASE_OUTPUT)

abstract: $(ABSTRACT_OUTPUT)

clean: $(DRAFT_INPUT)
	latexmk -c -cd -outdir=$(DRAFT_OUTDIR) -xelatex $<

$(RELEASE_OUTPUT): $(RELEASE_INPUT)
	latexmk -cd -outdir=$(RELEASE_OUTDIR) -jobname=%A-v$(VERSION) -xelatex $<;
	latexmk -c -cd -outdir=$(RELEASE_OUTDIR) -jobname=%A-v$(VERSION) -xelatex $<

$(DRAFT_OUTPUT): $(DRAFT_INPUT)
	latexmk -cd -outdir=$(DRAFT_OUTDIR) -xelatex $<;
	latexmk -c -cd -outdir=$(DRAFT_OUTDIR) -xelatex $<

watch: $(DRAFT_INPUT)
	latexmk -cd -outdir=$(DRAFT_OUTDIR) -pvc -xelatex $<

hooks:
	find .git/hooks -type l -exec rm {} \; && find .githooks -type f -exec ln -sf ../../{} .git/hooks/ \;
	.git/hooks/post-commit  \;

count:
	wc src/section/*.tex > wc.txt 
