<?xml version='1.0'?>
 
<!--
	Copyright (c) 2007-2009 Red Hat, Inc.
	License: GPLv2+ or Artistic
	Author: Jeff Fearn <jfearn@redhat.com>
	Author: Tammy Fox <tfox@redhat.com>
	Author: Andy Fitzsimon <afitzsim@redhat.com>
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
				xmlns:exsl="http://exslt.org/common"
				version="1.0"
				exclude-result-prefixes="exsl">

<xsl:import href="deps.xsl"/>

<xsl:include href="defaults.xsl"/>
<xsl:include href="xhtml-common.xsl"/>

<xsl:param name="generate.legalnotice.link" select="0"/>
<xsl:param name="generate.revhistory.link" select="0"/>

<xsl:param name="chunk.section.depth" select="1"/>
<xsl:param name="chunk.first.sections" select="1"/>
<xsl:param name="chunk.toc" select="''"/>
<xsl:param name="chunk.append"/>
<xsl:param name="chunker.output.quiet" select="0"/>
<!--<xsl:param name="base.dir">html/</xsl:param>-->
<xsl:param name="use.id.as.filename" select="1"/>
<xsl:param name="prod.url">http://www.wintermeyer.de/</xsl:param>
<xsl:param name="doc.url">http://www.wintermeyer.de/</xsl:param>
<xsl:param name="default.image.width" select="'700px'"/>
<xsl:param name="generate.toc">
set toc
book toc
article toc
chapter toc
part toc
section nop
set nop
sect1 nop
sect2 nop
sect3 nop
sect4 nop
sect5 nop
qandadiv nop
qandaset nop
</xsl:param>


<xsl:param name="admon.graphics" select="1"/>
<xsl:param name="admon.graphics.extension">.png</xsl:param>
<xsl:param name="admon.graphics.path">custom-admons-callouts/</xsl:param>

<xsl:param name="callout.graphics" select="1"/>
<xsl:param name="callout.graphics.extension">.png</xsl:param>
<xsl:param name="callout.graphics.path">custom-admons-callouts/callouts/</xsl:param>


<!--<xsl:param name="embedtoc" select="1"/>-->

<!--
From: xsl/docbook/1.72.0/xhtml/chunk-code.xsl
Reason: remove inline css from hr
Version: 1.72.0
-->
<xsl:template name="process.footnotes">
  <xsl:variable name="footnotes" select=".//footnote"/>
  <xsl:variable name="fcount">
    <xsl:call-template name="count.footnotes.in.this.chunk">
      <xsl:with-param name="node" select="."/>
      <xsl:with-param name="footnotes" select="$footnotes"/>
    </xsl:call-template>
  </xsl:variable>

<!--
  <xsl:message>
    <xsl:value-of select="name(.)"/>
    <xsl:text> fcount: </xsl:text>
    <xsl:value-of select="$fcount"/>
  </xsl:message>
-->

  <!-- Only bother to do this if there's at least one non-table footnote -->
  <xsl:if test="$fcount &gt; 0">
    <div class="footnotes" xmlns="http://www.w3.org/1999/xhtml">
      <br/>
      <hr/>
      <xsl:call-template name="process.footnotes.in.this.chunk">
        <xsl:with-param name="node" select="."/>
        <xsl:with-param name="footnotes" select="$footnotes"/>
      </xsl:call-template>
    </div>
  </xsl:if>

  <!-- FIXME: When chunking, only the annotations actually used
              in this chunk should be referenced. I don't think it
              does any harm to reference them all, but it adds
              unnecessary bloat to each chunk. -->
  <xsl:if test="$annotation.support != 0 and //annotation">
    <div class="annotation-list">
      <div class="annotation-nocss">
        <p>The following annotations are from this essay. You are seeing
        them here because your browser doesn&#8217;t support the user-interface
        techniques used to make them appear as &#8216;popups&#8217; on modern browsers.</p>
      </div>

      <xsl:apply-templates select="//annotation" mode="annotation-popup"/>
    </div>
  </xsl:if>
</xsl:template>
<!--
From: xhtml/chunk-common.xsl
Reason: remove tables, truncate link text
Version:
-->
<xsl:template name="header.navigation">
	<xsl:param name="prev" select="/foo"/>
	<xsl:param name="next" select="/foo"/>
	<xsl:param name="nav.context"/>
	<xsl:variable name="home" select="/*[1]"/>
	<xsl:variable name="up" select="parent::*"/>
	<xsl:variable name="row1" select="$navig.showtitles != 0"/>
	<xsl:variable name="row2" select="count($prev) &gt; 0 or (count($up) &gt; 0 and generate-id($up) != generate-id($home) and $navig.showtitles != 0) or count($next) &gt; 0"/>
	<xsl:if test="$suppress.navigation = '0' and $suppress.header.navigation = '0'">
		<xsl:if test="$row1 or $row2">
			<xsl:if test="$row1">
				<!--<p xmlns="http://www.w3.org/1999/xhtml">
					<xsl:attribute name="id">
						<xsl:text>title</xsl:text>
					</xsl:attribute>
					<a class="left">
						<xsl:attribute name="href">
							<xsl:value-of select="$prod.url"/>
						</xsl:attribute>
						<img src="images/image_left.png" alt="Product Site"/>
					</a>
					<a class="right">
						<xsl:attribute name="href">
							<xsl:value-of select="$doc.url"/>
						</xsl:attribute>
						<img src="images/image_right.png" alt="Documentation Site"/>
					</a>
				</p>-->
			</xsl:if>
			<xsl:if test="$row2">
				<ul class="docnav top" xmlns="http://www.w3.org/1999/xhtml">
					<li class="previous">
						<xsl:if test="count($prev)&gt;0">
							<a accesskey="p">
								<xsl:attribute name="href">
									<xsl:call-template name="href.target">
										<xsl:with-param name="object" select="$prev"/>
									</xsl:call-template>
								</xsl:attribute>
								<strong>
									<xsl:call-template name="navig.content">
										<xsl:with-param name="direction" select="'prev'"/>
									</xsl:call-template>
								</strong>
							</a>
						</xsl:if>
					</li>
					<li class="next">
						<xsl:if test="count($next)&gt;0">
							<a accesskey="n">
								<xsl:attribute name="href">
									<xsl:call-template name="href.target">
										<xsl:with-param name="object" select="$next"/>
									</xsl:call-template>
								</xsl:attribute>
								<strong>
									<xsl:call-template name="navig.content">
										<xsl:with-param name="direction" select="'next'"/>
									</xsl:call-template>
								</strong>
							</a>
						</xsl:if>
					</li>
				</ul>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$header.rule != 0">
			<hr/>
		</xsl:if>
	</xsl:if>
</xsl:template>

<!--
From: xhtml/chunk-common.xsl
Reason: remove tables, truncate link text
Version:
-->
<xsl:template name="footer.navigation">
	<xsl:param name="prev" select="/foo"/>
	<xsl:param name="next" select="/foo"/>
	<xsl:param name="nav.context"/>
	<xsl:param name="title-limit" select="'50'"/>
	<xsl:variable name="home" select="/*[1]"/>
	<xsl:variable name="up" select="parent::*"/>
	<xsl:variable name="row1" select="count($prev) &gt; 0 or count($up) &gt; 0 or count($next) &gt; 0"/>
	<xsl:variable name="row2" select="($prev and $navig.showtitles != 0) or (generate-id($home) != generate-id(.) or $nav.context = 'toc') or ($chunk.tocs.and.lots != 0 and $nav.context != 'toc') or ($next and $navig.showtitles != 0)"/>

	<xsl:if test="$suppress.navigation = '0' and $suppress.footer.navigation = '0'">
		<xsl:if test="$footer.rule != 0">
			<hr/>
		</xsl:if>
		<xsl:if test="$row1 or $row2">
			<ul class="docnav bottom" xmlns="http://www.w3.org/1999/xhtml">
				<xsl:if test="$row1">
					<li class="previous">
						<xsl:if test="count($prev) &gt; 0">
							<a accesskey="p">
								<xsl:attribute name="href">
									<xsl:call-template name="href.target">
										<xsl:with-param name="object" select="$prev"/>
									</xsl:call-template>
								</xsl:attribute>
								<strong>
									<xsl:call-template name="navig.content">
										<xsl:with-param name="direction" select="'prev'"/>
									</xsl:call-template>
								</strong>
								<xsl:variable name="text">
									<xsl:apply-templates select="$prev" mode="object.title.markup"/>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="string-length($text) &gt; $title-limit">
										<xsl:value-of select="concat(substring($text, 0, $title-limit), '...')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$text"/>
									</xsl:otherwise>
								</xsl:choose>
							</a>
						</xsl:if>
					</li>
					<xsl:if test="count($up) &gt; 0">
						<li class="up">
							<a accesskey="u">
								<xsl:attribute name="href">
									<xsl:text>#</xsl:text>
								</xsl:attribute>
								<strong>
									<xsl:call-template name="navig.content">
										<xsl:with-param name="direction" select="'up'"/>
									</xsl:call-template>
								</strong>
							</a>
						</li>
					</xsl:if>
					<xsl:if test="$home != . or $nav.context = 'toc'">
						<li class="home">
							<a accesskey="h">
								<xsl:attribute name="href">
									<xsl:call-template name="href.target">
										<xsl:with-param name="object" select="$home"/>
									</xsl:call-template>
								</xsl:attribute>
								<strong>
									<xsl:call-template name="navig.content">
										<xsl:with-param name="direction" select="'home'"/>
									</xsl:call-template>
								</strong>
							</a>
						</li>
					</xsl:if>
					<xsl:if test="count($next)&gt;0">
						<li class="next">
							<a accesskey="n">
								<xsl:attribute name="href">
									<xsl:call-template name="href.target">
										<xsl:with-param name="object" select="$next"/>
									</xsl:call-template>
								</xsl:attribute>
								<strong>
									<xsl:call-template name="navig.content">
										<xsl:with-param name="direction" select="'next'"/>
									</xsl:call-template>
								</strong>
								<xsl:variable name="text">
									<xsl:apply-templates select="$next" mode="object.title.markup"/>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="string-length($text) &gt; $title-limit">
										<xsl:value-of select="concat(substring($text, 0, $title-limit),'...')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="$text"/>
									</xsl:otherwise>
								</xsl:choose>
							</a>
						</li>
					</xsl:if>
				</xsl:if>
			</ul>
		</xsl:if>
	</xsl:if>
</xsl:template>

<!--
From: xhtml/chunk-common.xsl
Reason: add TOC div for web site
Version:
-->
<xsl:template name="chunk-element-content">
  <xsl:param name="prev"/>
  <xsl:param name="next"/>
  <xsl:param name="nav.context"/>
  <xsl:param name="content">
    <xsl:apply-imports/>
  </xsl:param>

  <xsl:call-template name="user.preroot"/>

  <html>
    <xsl:call-template name="html.head">
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>
    
    <body id="your-body">
      <xsl:call-template name="body.attributes"/>
      <xsl:if test="$embedtoc != 0">
      <div id="tocdiv" class="toc">
        <object><xsl:attribute name="id">tocframe</xsl:attribute><xsl:attribute name="class">toc</xsl:attribute><xsl:attribute name="data"><xsl:value-of select="$l10n.gentext.language"/>index.html</xsl:attribute><xsl:attribute name="type">text/html</xsl:attribute></object>
      </div>
      </xsl:if>
      <div id="content">
      <div id="content-inner">
      	<div id="rightcol" class="sidebar">
	      <xsl:call-template name="breadcrumbs"/>
      	
      	<div id="textsize">
      	<span class="textts"> Change Text Size</span><br/>
	<!--<a href="javascript:void(0);" onclick="javascript:body.style.fontSize='9px'"><span class="plusts" style="font-size: xx-small;">+</span></a> <a href="javascript:void(0);" onclick="javascript:body.style.fontSize='11px'"><span class="plusts" style="font-size: x-small;">+</span></a>-->
	<a href="javascript:void(0);" onclick="javascript:body.style.fontSize='13px'"><span class="plusts" style="font-size: small;">+</span></a> <a href="javascript:void(0);" onclick="javascript:body.style.fontSize='15px'"><span class="plusts" style="font-size: large;">+</span></a> <a href="javascript:void(0);" onclick="javascript:body.style.fontSize='17px'"><span class="plusts" style="font-size: x-large;">+</span></a>
		</div>
		<div id="adsense" align="center">

      		<xsl:if test="$adincluded = 1">
     		<script type="text/javascript">
      			<xsl:text disable-output-escaping="yes">
      				<!--ADD YOUR AD INSIDE THE CDATA SECTION-->
					<![CDATA[<!--]]>
				</xsl:text>
				<!--<xsl:variable name="adfile" select="document('ad.xml',/)"/>-->
				<xsl:copy-of select="$adfile/ad/node()"/>
      			<xsl:text disable-output-escaping="yes">
					<![CDATA[//-->]]>
				</xsl:text>
			</script>
			<script type="text/javascript"
			src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
			</script>
			</xsl:if>
		</div>	
      	</div>
      <div id="maincol">
      <xsl:call-template name="user.header.navigation"/>
        <xsl:call-template name="header.navigation">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="nav.context" select="$nav.context"/>
      </xsl:call-template>

      <xsl:call-template name="user.header.content"/>

      <xsl:copy-of select="$content"/>

      <xsl:call-template name="user.footer.content"/>

      <xsl:call-template name="footer.navigation">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="nav.context" select="$nav.context"/>
      </xsl:call-template>

      <xsl:call-template name="user.footer.navigation"/>
      </div>
      
      	<div class="clear"></div>
      </div>
      </div>
    </body>
  </html>
  <xsl:value-of select="$chunk.append"/>
</xsl:template>

<xsl:template name="breadcrumbs">
  <xsl:param name="this.node" select="."/>
  <ul class="breadcrumbs">
    <xsl:for-each select="$this.node/ancestor::*">
      <li>
   		<xsl:attribute name="class">
   			<xsl:text>breadcrumb-link</xsl:text>
	      	<xsl:if test="position() != 1">
    	  		<xsl:text> breadcrumb-bullet</xsl:text>
    	  	</xsl:if>
      	</xsl:attribute>
      	<xsl:attribute name="style">
      		<xsl:text>margin-left: </xsl:text>
      		<xsl:value-of select="(position() - 1) * 0.8"/>
      		<xsl:text>em</xsl:text>
      	</xsl:attribute>
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="."/>
              <xsl:with-param name="context" select="$this.node"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:apply-templates select="." mode="title.markup"/>
        </a>
      </li>
      <xsl:if test="position() = last()">
      		<xsl:call-template name="last-li-breadcrumb">
      			<xsl:with-param name="padding" select="(position() - 1) * 0.8"/>
      			<xsl:with-param name="last-li-node" select="$this.node"/>
      		</xsl:call-template>
      	</xsl:if>
    </xsl:for-each>
    <xsl:if test="count($this.node/ancestor::*) = 0">
    	<li class="breadcrumb-node breadcrumb-last">
    		<xsl:apply-templates select="$this.node" mode="title.markup"/>
      	</li>
    </xsl:if>

  </ul>
</xsl:template>

<xsl:template name="last-li-breadcrumb">
  <xsl:param name="last-li-node"/>
  <xsl:param name="padding"/>
<!-- And display the current node, but not as a link -->
    <li>
    	<xsl:attribute name="class">
      		<xsl:text>breadcrumb-node breadcrumb-last breadcrumb-bullet</xsl:text>
      	</xsl:attribute>
    	<xsl:attribute name="style">
      		<xsl:text>margin-left: </xsl:text>
      		<xsl:value-of select="$padding + 0.8"/>
      		<xsl:text>em</xsl:text>
      	</xsl:attribute>
      	<xsl:choose>
      		<xsl:when test="count($last-li-node/child::*[name()!='para']) = 1">
      			<xsl:apply-templates select="$last-li-node" mode="title.markup"/>
      		</xsl:when>
      		<xsl:otherwise>
      			<a>
				  <xsl:attribute name="href">
					<xsl:call-template name="href.target">
					  <xsl:with-param name="object" select="$last-li-node"/>
					</xsl:call-template>
				  </xsl:attribute>
				  <xsl:apply-templates select="$last-li-node" mode="title.markup"/>
				</a>
      		</xsl:otherwise>
      	</xsl:choose>
    </li>
    <xsl:for-each select="$last-li-node/child::*[name()!='para' and position() != 1]">
    	
      <li>
   		<xsl:attribute name="class">
   			<xsl:text>breadcrumb-link breadcrumb-bullet-another</xsl:text>
      	</xsl:attribute>
      	<xsl:attribute name="style">
      		<xsl:text>margin-left: </xsl:text>
      		<xsl:value-of select="$padding + 0.8 + 0.8"/>
      		<xsl:text>em</xsl:text>
      	</xsl:attribute>
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="."/>
              <xsl:with-param name="context" select="$last-li-node"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:apply-templates select="." mode="title.markup"/>
        </a>
      </li>
      </xsl:for-each>
</xsl:template>


</xsl:stylesheet>
