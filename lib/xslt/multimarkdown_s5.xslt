<?xml version='1.0' encoding='utf-8'?>

<!-- XHTML-to-S5 converted by Fletcher Penney and Jared Smith
	specifically designed for use with MultiMarkdown created XHTML
	
	MultiMarkdown Version 2.0.b5
	
	$Id: s5.xslt 478 2008-01-12 23:03:47Z fletcher $
-->

<!-- 
# Copyright (C) 2005-2008  Fletcher T. Penney <fletcher@fletcherpenney.net>
# Copyright (C) 2009  Jared K. Smith <jared@jaredsmith.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the
#    Free Software Foundation, Inc.
#    59 Temple Place, Suite 330
#    Boston, MA 02111-1307 USA
-->

<!-- 
	TODO: an option to select what h-level should be slides (for instance, if h2, then each h1 would be a slide, containing list of h2's.  Then h2's converted into slides....
	
	-->
	
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xhtml xsl"
	version="1.0">

	<xsl:output 
    method='xml' encoding='utf-8' indent="yes"
  	omit-xml-declaration="yes"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>

	<xsl:strip-space elements="*" />

	<!-- change this to reflect the relative path to your S5
	     installation and theme, without a trailing slash -->
	<xsl:variable name="s5_relative_path">ui/default</xsl:variable>

	<xsl:param name="match"/>

	<xsl:template match="/">
		<html>
		<xsl:apply-templates select="node()"/>
		</html>
	</xsl:template>

	<xsl:template match="xhtml:head">
		<head>
		<xsl:apply-templates select="xhtml:meta"/>
		<xsl:apply-templates select="node()"/>
		<xsl:comment> metadata </xsl:comment>
		<meta name="generator" content="MultiMarkdown"/>
		<meta name="version" content="S5 1.1" />
		<meta name="presdate">
			<!-- if presdate exists, use it.  Otherwise, default to 1 Jan 1970 -->
			<xsl:attribute name="content">
				<xsl:variable name="presdate">
					<xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'presdate']/@content"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="boolean($presdate)">
						<xsl:value-of select="$presdate"/>
					</xsl:when>
					<xsl:otherwise>
						19700101
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</meta>
    <meta name="author">
      <xsl:attribute name="content">
        <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'author']/@content"/>
      </xsl:attribute>
    </meta>
    <meta name="company">
      <xsl:attribute name="content">
        <xsl:variable name="company">
          <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'company']/@content"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="boolean($company)">
          </xsl:when>
          <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </meta>
		<xsl:comment> configuration parameters </xsl:comment>
		<meta name="defaultView" content="slideshow"/>
		<meta name="controlVis" content="hidden"/>
		<xsl:comment> style sheet links </xsl:comment>
		<link rel="stylesheet" href="{$s5_relative_path}/slides.css" type="text/css" media="projection" id="slideProj" />
    <!--
		<style>@import url(<xsl:value-of select="$s5_relative_path"/>/pretty.css);</style>
    -->
		<link rel="stylesheet" href="{$s5_relative_path}/outline.css" type="text/css" media="screen" id="outlineStyle" />
		<link rel="stylesheet" href="{$s5_relative_path}/print.css" type="text/css" media="print" id="slidePrint" />
		<link rel="stylesheet" href="{$s5_relative_path}/opera.css" type="text/css" media="projection" id="operaFix" />
		<xsl:comment> S5 JS </xsl:comment>
		<script src="{$s5_relative_path}/slides.js" type="text/javascript"></script>
		</head>
	</xsl:template>

	<xsl:template match="xhtml:title">
		<title><xsl:value-of select="."/></title>
	</xsl:template>

	<xsl:template match="xhtml:body">
		<body>

		<xsl:comment>START header slide</xsl:comment>

		<div class="layout">
			<div id="controls"><xsl:comment> DO NOT EDIT </xsl:comment></div>
			<div id="currentSlide"><xsl:comment> DO NOT EDIT </xsl:comment></div>
			<div id="header"></div>

			<xsl:comment> blackout and whiteout divs DO NOT EDIT </xsl:comment>
			<div id="whiteoutbox" class="whiteout"></div>
			<div id="blackoutbox" class="blackout"></div>

			<div id="footer">
			<h1><xsl:value-of select="/xhtml:html/xhtml:head/xhtml:title"/></h1>
			<h2>
				<xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'author']/@content"/>
			</h2>
			</div>
		</div>
		<div class="presentation">
		<xsl:comment> start header slide </xsl:comment>
		<div class="slide">
		<h1><xsl:value-of select="/xhtml:html/xhtml:head/xhtml:title"/></h1>
		<h2><xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'subtitle']/@content"/></h2>
		<h3>
		<xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'author']/@content"/>
		</h3>
		<xsl:variable name="url">
			<xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'url']/@content"/>
		</xsl:variable>
    <xsl:if test="string-length($url) > 6">
      <h4>
        <xsl:comment>URL</xsl:comment>
        <a href="{$url}">
  <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'organization']/@content"/>
        </a>
      </h4>
    </xsl:if>
    <xsl:variable name="presdate">
      <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'presdate']/@content"/>
    </xsl:variable>
    <xsl:if test="boolean($presdate)">
      <h4>
        <xsl:value-of select="/xhtml:html/xhtml:head/xhtml:meta[translate(@name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz') = 'presdate']/@content"/>
      </h4>				
    </xsl:if>
		</div>
		
		<xsl:apply-templates select="xhtml:h1"/>
		</div>
		</body>
	</xsl:template>


	<xsl:template match="xhtml:h1">
		<div class="slide">
			<h1><xsl:value-of select="."/></h1>	
			<xsl:variable name="items" select="count(following-sibling::*) - count(following-sibling::xhtml:h1[1]/following-sibling::*) - count(following-sibling::xhtml:h1[1])"/>
			<xsl:apply-templates select="following-sibling::*[position() &lt;= $items]" mode="slide"/>
		</div>		
	</xsl:template>

	<xsl:template match="xhtml:h1[last()]">
		<div class="slide">
		<h1><xsl:value-of select="."/></h1>
		<xsl:variable name="items" select="count(following-sibling::*) - count(following-sibling::h1/following-sibling::*)"/>
		<xsl:apply-templates select="following-sibling::*[position() &lt;= $items]" mode="slide"/>
		</div>
	</xsl:template>

	<xsl:template match="xhtml:p" mode="slide">
		<xsl:copy-of select="."/>
	</xsl:template>

	<xsl:template match="xhtml:p[1]" mode="slide">
		<xsl:copy-of select="."/>
	</xsl:template>

	<xsl:template match="xhtml:li" mode="slide">
		<li>
		<xsl:apply-templates select="node()" mode="slide"/>
		</li>
	</xsl:template>

	<xsl:template match="xhtml:ol" mode="slide">
<!--		<ol class="incremental show-first"> -->
		<ol>
			<xsl:apply-templates select="node()" mode="slide"/>
		</ol>
	</xsl:template>

	<xsl:template match="xhtml:ul" mode="slide">
		<ul>
			<xsl:apply-templates select="node()" mode="slide"/>
		</ul>
	</xsl:template>
</xsl:stylesheet>
<!--
     vim600: syn=xml fen fdm=syntax fdl=2 si
     vim: et tw=78 syn=sgml
     vi: ts=2 sw=2
-->
