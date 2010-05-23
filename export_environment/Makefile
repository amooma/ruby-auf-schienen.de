CURDIR = $(shell pwd)
include $(CURDIR)/Makefile.inc

all: pdf html epub

pdf: $(PDFDIR)/Makefile
	cd ${PDFDIR} && $(MAKE)

html: $(HTMLDIR)/Makefile
	cd ${HTMLDIR} && $(MAKE) 

epub: $(EPUBDIR)/Makefile
	cd ${EPUBDIR} && $(MAKE) 

pdfclean: $(PDFDIR)/Makefile
	cd ${PDFDIR} && $(MAKE) clean

htmlclean: $(HTMLDIR)/Makefile
	cd ${HTMLDIR} && $(MAKE) clean

epubclean: $(EPUBDIR)/Makefile
	cd ${EPUBDIR} && $(MAKE) clean

clean: pdfclean htmlclean epubclean
