<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:functx="http://www.functx.com"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  exclude-result-prefixes="#all">

  <!-- pinched from functx at http://www.xsltfunctions.com/xsl/functx_words-to-camel-case.html -->

  <xsl:function name="functx:lowercase-or-capitalize-first" as="xs:string?"
              xmlns:functx="http://www.functx.com">
    <xsl:param name="arg" as="xs:string?"/>
    <xsl:param name="pos" as="xs:integer?"/>

    <xsl:sequence select="if ($pos = 0) then concat(lower-case(substring($arg,1,1)), substring($arg,2)) else concat(upper-case(substring($arg,1,1)), substring($arg,2)) "/>

  </xsl:function>

  <xsl:function name="functx:words-to-camel-case" as="xs:string"
              xmlns:functx="http://www.functx.com">
    <xsl:param name="arg" as="xs:string?"/>

    <!-- disable lower case for now - doesn't work for acronyms -->
    <xsl:sequence select="string-join((functx:lowercase-or-capitalize-first(tokenize($arg,'\s+')[1],1),
       for $word in tokenize($arg,'\s+')[position() > 1] 
         return functx:lowercase-or-capitalize-first($word,1)) 
       ,'')"/>

  </xsl:function>

</xsl:stylesheet>
