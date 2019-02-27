<?xml version="1.0" encoding="UTF-8"?>

<!-- This XSLT will read and process an input XML document from the RasterMeta database
     dump - this reads the sensors.xml file and builds a 19115-3 sensor fragment -->


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
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:functx="http://www.functx.com"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  exclude-result-prefixes="functx xs xsl">

  <xsl:import href="functions.xsl"/>

  <xsl:output method="xml" indent="yes" name="xml"/>

  <xsl:variable name="platforms" select="document('../RASTERAPP.RT_PLATFORM.xml')"/>
  <xsl:variable name="sensornames" select="document('../RASTERAPP.RT_SENSORNAME.xml')"/>
  <xsl:variable name="sensortypes" select="document('../RASTERAPP.RT_SENSORTYPE.xml')"/>

  <xsl:template match="DATA_RECORD">
    <xsl:variable name="sensorid" select="SENSORID"/>
    <xsl:message><xsl:value-of select="$sensorid"/></xsl:message>
    <xsl:variable name="platformid" select="PLATFORMID"/>
    <xsl:variable name="sensornameid" select="SENSORNAMEID"/>
    <xsl:variable name="sensortypeid" select="SENSORTYPEID"/>
    <xsl:variable name="platform" select="functx:words-to-camel-case($platforms//DATA_RECORD[PLATFORMID=$platformid]/DESCRIPTION)"/>
    <xsl:variable name="sensorname" select="$sensornames//DATA_RECORD[SENSORNAMEID=$sensornameid]/DESCRIPTION"/>
    <xsl:variable name="sensortype" select="$sensortypes//DATA_RECORD[SENSORTYPEID=$sensortypeid]/DESCRIPTION"/>
    <xsl:message> Platform: <xsl:value-of select="$platform"/></xsl:message>
    <xsl:message> Sensor Name: <xsl:value-of select="$sensorname"/></xsl:message>
    <xsl:message> Sensor Type: <xsl:value-of select="$sensortype"/></xsl:message>

    <xsl:variable name="filename" select="concat('sensors/',$sensorid,'.xml')" />
    <xsl:result-document href="{$filename}" format="xml">
        <mac:MI_Sensor id="{$sensorid}" uuid="urn:delwp-sensors:{$sensorid}"
                       title="{concat($platform,': ',$sensorname)}">
            <mac:identifier>
              <mcc:MD_Identifier>
                <mcc:code>
                  <gco:CharacterString><xsl:value-of select="$sensorname"/></gco:CharacterString>
                </mcc:code>
              </mcc:MD_Identifier>
            </mac:identifier>
            <mac:type>
               <gco:CharacterString><xsl:value-of select="$sensortype"/></gco:CharacterString>
            </mac:type>
            <mac:otherProperty>
              <gco:Record xsi:type="delwp:MD_SensorProperties_Type">
                <delwp:platformType>
                  <delwp:MD_PlatformTypeCode codeList="codeListLocation#MD_PlatformTypeCode" codeListValue="{$platform}"/>
                </delwp:platformType>
              </gco:Record>
            </mac:otherProperty>
        </mac:MI_Sensor>
    </xsl:result-document>

  </xsl:template>

  <!-- ================================================================= -->
  <!-- Match any element (node()) or attribute @* then apply templates to the children of 
       this element ie. recursively process the entire input document but only the matches 
       for the templates above will have any effect -->
  <xsl:template match="@*|node()">
    <xsl:apply-templates select="@*|node()"/>
  </xsl:template>

  <!-- ================================================================= -->

</xsl:stylesheet>
