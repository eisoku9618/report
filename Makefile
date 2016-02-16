TARGET ?= example
# ALLDIRS := $(shell find ./ -maxdepth 1 -type d | grep -v "\/\.")
ALLTEXFILES := $(shell find ./ -maxdepth 2 -type f -name "*.tex" | xargs grep -l "\\\\documentclass")
LATEXRUN := $(abspath .latexrun/latexrun)
TMPDIR := ".tmp"


all: $(ALLTEXFILES)

$(ALLTEXFILES): FORCE
	@echo "BUILDING : "$@
	@cd $(dir $@) && \
	TEXINPUTS="styles:" $(LATEXRUN) --debug --latex-cmd=xelatex --bibtex-cmd=pbibtex -O $(TMPDIR) $(notdir $@)

clean: FORCE
	$(LATEXRUN) -O $(TARGET)/$(TMPDIR) --clean-all

distclean: clean FORCE
	@echo "target directory : "$(dir $(ALLTEXFILES))
	@for d in $(dir $(ALLTEXFILES)); do (cd $$d; $(LATEXRUN) -O $(TMPDIR) --clean-all; rm -rf $(TMPDIR)); done

.PHONY: FORCE clean distclean all
