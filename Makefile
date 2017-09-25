TARGET ?= example
# ALLDIRS := $(shell find ./ -maxdepth 1 -type d | grep -v "\/\.")
ALLTEXFILES := $(shell find ./ -maxdepth 2 -type f -name "*.tex" | xargs grep -l "\\\\documentclass")
LATEXRUN := $(abspath 3rdparty/latexrun)
TMPDIR := ".tmp"
LATEXRUNARGS ?=  # make LATEXRUNARGS=--debug

all: $(ALLTEXFILES)

$(ALLTEXFILES): FORCE
	$(eval FNAME := $(notdir $@))
	@echo "BUILDING : "$@
	cd $(dir $@) && \
	TEXINPUTS="styles:" $(LATEXRUN) $(LATEXRUNARGS) --latex-cmd=xelatex --bibtex-cmd=pbibtex -O $(TMPDIR) $(FNAME) && \
	cp $(TMPDIR)/$(FNAME:.tex=.pdf) $(FNAME:.tex=.pdf)

clean: FORCE
	$(LATEXRUN) -O $(TARGET)/$(TMPDIR) --clean-all

distclean: clean FORCE
	@echo "target directory : "$(dir $(ALLTEXFILES))
	@for d in $(dir $(ALLTEXFILES)); do (cd $$d; $(LATEXRUN) -O $(TMPDIR) --clean-all; rm -rf $(TMPDIR)); done
	@rm -f echo $(patsubst %.tex, %.pdf, $(ALLTEXFILES))

.PHONY: FORCE clean distclean all
