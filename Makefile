# If needed you may add in the tag "all: " additional parameters such as pdf, rtf, or docx.
# For this instance we are using only html that we connect with out gh-pages.

OUT_DIR=web
IN_DIR=markdown
STYLES_DIR=styles
STYLE=chmduquesne

all: html pdf docx rtf

.PHONY: check-context
check-context:
	@command -v context >/dev/null 2>&1 || { \
		echo "Error: ConTeXt (context) is required to build PDFs. See README.md for installation and PATH setup." >&2; \
		exit 1; \
	}

pdf: check-context init
	set -e; for f in $(IN_DIR)/*.md; do \
		FILE_NAME=`basename $$f | sed 's/.md//g'`; \
		echo $$FILE_NAME.pdf; \
		pandoc --standalone --template $(STYLES_DIR)/$(STYLE).tex \
			--from markdown --to context \
			--variable papersize=A4 \
			--output $(OUT_DIR)/$$FILE_NAME.tex $$f > /dev/null; \
		(cd $(OUT_DIR) && context $$FILE_NAME.tex \
			--result=$$FILE_NAME.pdf) > $(OUT_DIR)/context_$$FILE_NAME.log 2>&1 || { \
			cat $(OUT_DIR)/context_$$FILE_NAME.log >&2; \
			exit 1; \
		}; \
		if [ ! -s $(OUT_DIR)/$$FILE_NAME.pdf ]; then \
			echo "Error: ConTeXt did not produce $(OUT_DIR)/$$FILE_NAME.pdf. See $(OUT_DIR)/context_$$FILE_NAME.log." >&2; \
			exit 1; \
		fi; \
	done

html: init
	for f in $(IN_DIR)/*.md; do \
		FILE_NAME=`basename $$f | sed 's/.md//g'`; \
		echo $$FILE_NAME.html; \
		pandoc --standalone --include-in-header $(STYLES_DIR)/$(STYLE).css \
			--from markdown --to html \
			--output $(OUT_DIR)/$$FILE_NAME.html $$f; \
	done

docx: init
	for f in $(IN_DIR)/*.md; do \
		FILE_NAME=`basename $$f | sed 's/.md//g'`; \
		echo $$FILE_NAME.docx; \
		pandoc --standalone $$SMART $$f --output $(OUT_DIR)/$$FILE_NAME.docx; \
	done

rtf: init
	for f in $(IN_DIR)/*.md; do \
		FILE_NAME=`basename $$f | sed 's/.md//g'`; \
		echo $$FILE_NAME.rtf; \
		pandoc --standalone $$SMART $$f --output $(OUT_DIR)/$$FILE_NAME.rtf; \
	done

init: dir version

dir:
	mkdir -p $(OUT_DIR)

version:
	PANDOC_VERSION=`pandoc --version | head -1 | cut -d' ' -f2 | cut -d'.' -f1`; \
	if [ "$$PANDOC_VERSION" -eq "2" ]; then \
		SMART=-smart; \
	else \
		SMART=--smart; \
	fi \

clean:
	rm -f $(OUT_DIR)/*
