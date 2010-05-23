CURDIR = $(shell pwd)
TOPDIR = $(CURDIR)/../..
include $(TOPDIR)/Makefile.inc
DOCBOOKNSDIR_CLEANED = $(shell cd ${DOCBOOKNSDIR}; pwd | awk -F"$$" {'print $1'})

DOCBOOKXSLPATH :=  ${DOCBOOKNSDIR_CLEANED}/xhtml/docbook.xsl
CHUNKXSLPATH := ${DOCBOOKNSDIR_CLEANED}/xhtml/chunk.xsl
 
all: $(EXPORTDIR)/html/index.html
       
$(EXPORTDIR)/html/index.html: $(DOCBOOKSRCDIR)/index.xml
	rm -f deps.xsl

	echo "<?xml version='1.0'?>" >> deps.xsl
	echo "<xsl:stylesheet \
	xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" \
	xmlns:fo=\"http://www.w3.org/1999/XSL/Format\" \
	xmlns:d=\"http://docbook.org/ns/docbook\" \
	xmlns:exsl=\"http://exslt.org/common\" \
	extension-element-prefixes=\"exsl\" \
	exclude-result-prefixes=\"exsl d\" \
	version=\"1.0\">" >> deps.xsl
	echo "<xsl:import href=\"${DOCBOOKXSLPATH}\"/>" >> deps.xsl
	echo "<xsl:import href=\"${CHUNKXSLPATH}\"/>" >> deps.xsl
	echo "</xsl:stylesheet>" >> deps.xsl

	sed 's/.xsl \"/.xsl\"/' deps.xsl  > tmp.xsl; mv tmp.xsl deps.xsl

	mkdir -p $(EXPORTDIR)/html
	cp $(HTMLDIR)/default.css $(HTMLDIR)/common.css $(EXPORTDIR)/html
	cp -R ${DEPENDDIR}/custom-admons-callouts/ $(EXPORTDIR)/html
	cp -R ${DOCBOOKSRCDIR}/screenshots $(EXPORTDIR)/html
	@if test -f $(HTMLDIR)/ad.xml; then \
		xsltproc --stringparam base.dir $(EXPORTDIR)/html/ --stringparam admon.graphics.path ${DEPENDDIR}/custom-admons-callouts/ --stringparam callout.graphics.path ${DEPENDDIR}/custom-admons-callouts/ --stringparam adincluded 1 --xinclude $(HTMLDIR)/rubyonrails-html.xsl $(DOCBOOKSRCDIR)/index.xml; \
	else \
		xsltproc --stringparam base.dir $(EXPORTDIR)/html/ --stringparam admon.graphics.path ${DEPENDDIR}/custom-admons-callouts/ --stringparam callout.graphics.path ${DEPENDDIR}/custom-admons-callouts/ --stringparam adincluded 0 --xinclude $(HTMLDIR)/rubyonrails-html.xsl $(DOCBOOKSRCDIR)/index.xml; \
	fi
	
clean:
	rm -rf $(EXPORTDIR)/html
