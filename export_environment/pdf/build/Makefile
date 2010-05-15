all: document.pdf
       
document.pdf: build/document.fo
	fop -c build/font-config.xml -fo build/document.fo -pdf document.pdf
       
build/document.fo: index.xml
#	xsltproc -o document.fo --xinclude --stringparam use.extensions 0 --stringparam fop1.extensions 1 --stringparam draft.mode no 	--stringparam hyphenate false --stringparam l10n.gentext.default.language de --stringparam admon.graphics 1 --stringparam admon.graphics.extension .png --stringparam monospace.verbatim.properties wrap-option wrap /home/pratik/downloads/docbook-xsl-ns-1.75.2/fo/docbook.xsl index.xml
	xsltproc -o build/document.fo --xinclude build/rubyonrails-pdf.xsl index.xml

clean:
	rm -f build/document.fo document.pdf
