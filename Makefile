TARGET ?= example
# ALLDIRS := $(shell find ./ -maxdepth 1 -type d | grep -v "\/\.")
ALLTEXFILES := $(shell find ./ -maxdepth 2 -type f -name "*.tex" | xargs grep -l "\\\\documentclass")
LATEXRUN := $(abspath .latexrun/latexrun)
TMPDIR := ".tmp"
LATEXRUNARGS ?=  # make LATEXRUNARGS=--debug

all: $(ALLTEXFILES)

$(ALLTEXFILES): FORCE $(LATEXRUN)
	@echo "BUILDING : "$@
	cd $(dir $@) && \
	TEXINPUTS="styles:" $(LATEXRUN) $(LATEXRUNARGS) --latex-cmd=xelatex --bibtex-cmd=pbibtex -O $(TMPDIR) $(notdir $@)

clean: FORCE $(LATEXRUN)
	$(LATEXRUN) -O $(TARGET)/$(TMPDIR) --clean-all

distclean: clean FORCE
	@echo "target directory : "$(dir $(ALLTEXFILES))
	@for d in $(dir $(ALLTEXFILES)); do (cd $$d; $(LATEXRUN) -O $(TMPDIR) --clean-all; rm -rf $(TMPDIR)); done
	@rm -f echo $(patsubst %.tex, %.pdf, $(ALLTEXFILES))

$(LATEXRUN):
	if ! [ -f $(LATEXRUN) ]; then cd $(dir $(LATEXRUN)); git submodule init && git submodule update; fi

.PHONY: FORCE clean distclean all
