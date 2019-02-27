<?xml version="1.0" encoding="UTF-8"?>

<!-- This XSLT will read and process an input XML document - it will not change 
     the input document - hence the term identity.xsl -->

<!-- Include commonly used ISO19115-3 namespaces in preparation for processing these
     documents -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:mdb="http://standards.iso.org/iso/19115/-3/mdb/2.0"
  xmlns:mcc="http://standards.iso.org/iso/19115/-3/mcc/1.0"
  xmlns:mri="http://standards.iso.org/iso/19115/-3/mri/1.0"
  xmlns:mrs="http://standards.iso.org/iso/19115/-3/mrs/1.0"
  xmlns:mrd="http://standards.iso.org/iso/19115/-3/mrd/1.0"
  xmlns:mac="http://standards.iso.org/iso/19115/-3/mac/2.0"
  xmlns:mco="http://standards.iso.org/iso/19115/-3/mco/1.0"
  xmlns:msr="http://standards.iso.org/iso/19115/-3/msr/2.0"
  xmlns:lan="http://standards.iso.org/iso/19115/-3/lan/1.0"
  xmlns:gcx="http://standards.iso.org/iso/19115/-3/gcx/1.0"
  xmlns:gex="http://standards.iso.org/iso/19115/-3/gex/1.0"
  xmlns:mdq="http://standards.iso.org/iso/19157/-2/mdq/1.0"
  xmlns:cit="http://standards.iso.org/iso/19115/-3/cit/2.0"
  xmlns:mrl="http://standards.iso.org/iso/19115/-3/mrl/2.0"
  xmlns:mmi="http://standards.iso.org/iso/19115/-3/mmi/1.0"
  xmlns:gco="http://standards.iso.org/iso/19115/-3/gco/1.0"
  xmlns:gmw="http://standards.iso.org/iso/19115/-3/gmw/1.0"
  xmlns:delwp="https://github.com/geonetwork-delwp/iso19115-3.2018"
  xmlns:gml="http://www.opengis.net/gml/3.2"
	xmlns:xlink="http://www.w3.org/1999/xlink">

  <!-- We will produce an output document that is XML, so indent the elements nicely in order
       to retain readability -->
	<xsl:output method="xml" indent="yes"/>

	<!-- ================================================================= -->
  <!-- Match any element (node()) or attribute @* and copy it, then apply templates to the 
       children of this element ie. recursively process the entire input document -->
	<xsl:template match="@*|node()">
		 <xsl:copy>
			  <xsl:apply-templates select="@*|node()"/>
		 </xsl:copy>
	</xsl:template>

	<!-- ================================================================= -->

</xsl:stylesheet>
