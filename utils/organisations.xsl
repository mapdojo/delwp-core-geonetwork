<?xml version="1.0" encoding="UTF-8"?>

<!-- This XSLT will read and process an input XML document from the RasterMeta database
     dump - this reads the data_organisations.xml file and builds 19115-3 CI_Organisation
     fragments -->


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

  <xsl:variable name="organisations" select="document('RASTERAPP.DATA_ORGANISATIONS.xml')"/>

  <xsl:template match="/">

   <xsl:for-each-group select="main/DATA_RECORD" group-by="CONTACTID">
    <xsl:variable name="orgid" select="ORGANISATIONID"/>
    <xsl:variable name="contactid" select="CONTACTID"/>
    <xsl:message><xsl:value-of select="$contactid"/></xsl:message>

    <xsl:variable name="org" select="$organisations//DATA_RECORD[ORGANISATIONID=$orgid]"/>

    <xsl:variable name="filename" select="concat('contacts/',$contactid,'.xml')" />

    <xsl:variable name="address">
      <xsl:choose>
        <xsl:when test="normalize-space($org/POSTALADDRESS)=''">
          <xsl:value-of select="$org/STREETADDRESS"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($org/STREETADDRESS,', ',$org/POSTALADDRESS)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="title">
      <xsl:value-of select="concat(LASTNAME,', ',FIRSTNAME,' @ ',$org/NAME)"/>
    </xsl:variable>

    <xsl:result-document href="{$filename}" format="xml">

    <cit:CI_Organisation uuid="urn:delwp-contacts:{$contactid}" title="{$title}">
      <cit:name> 
        <gco:CharacterString><xsl:value-of select="$org/NAME"/></gco:CharacterString>
      </cit:name> 
      <cit:contactInfo>
        <cit:CI_Contact>
          <cit:address>
            <cit:CI_Address>
              <cit:deliveryPoint>
                <gco:CharacterString><xsl:value-of select="$address"/></gco:CharacterString>
              </cit:deliveryPoint>
              <cit:city>
                <gco:CharacterString><xsl:value-of select="$org/CITY"/></gco:CharacterString>
              </cit:city>
              <cit:administrativeArea>
                <gco:CharacterString><xsl:value-of select="$org/STATEORPROVINCE"/></gco:CharacterString>
              </cit:administrativeArea>
              <cit:postalCode>
                <gco:CharacterString><xsl:value-of select="$org/POSTALCODE"/></gco:CharacterString>
              </cit:postalCode>
              <cit:country>
                <gco:CharacterString><xsl:value-of select="$org/COUNTRY"/></gco:CharacterString>
              </cit:country>
            </cit:CI_Address>
          </cit:address>
        </cit:CI_Contact>
      </cit:contactInfo>
      <cit:individual>
        <cit:CI_Individual>
          <cit:name> 
            <gco:CharacterString><xsl:value-of select="concat(FIRSTNAME,' ',LASTNAME)"/></gco:CharacterString>
          </cit:name> 
          <xsl:if test="normalize-space(WORKPHONE)!='' or
                        normalize-space(MOBILEPHONE)!='' or
                        normalize-space(FAXNUMBER)!=''">
          <cit:contactInfo>
            <cit:CI_Contact>
              <xsl:if test="normalize-space(WORKPHONE)!=''">
                <cit:phone>
                  <cit:CI_Telephone>
                    <cit:number>
                      <gco:CharacterString><xsl:value-of select="WORKPHONE"/></gco:CharacterString>
                    </cit:number>
                    <cit:numberType>
                      <cit:CI_TelephoneTypeCode codeList="codeListLocation#CI_TelephoneTypeCode" codeListValue="voice">voice</cit:CI_TelephoneTypeCode>
                    </cit:numberType>
                  </cit:CI_Telephone>
                </cit:phone>
              </xsl:if>
              <xsl:if test="normalize-space(MOBILEPHONE)!=''">
                <cit:phone>
                  <cit:CI_Telephone>
                    <cit:number>
                      <gco:CharacterString><xsl:value-of select="MOBILEPHONE"/></gco:CharacterString>
                    </cit:number>
                    <cit:numberType>
                      <cit:CI_TelephoneTypeCode codeList="codeListLocation#CI_TelephoneTypeCode" codeListValue="voice">voice</cit:CI_TelephoneTypeCode>
                    </cit:numberType>
                  </cit:CI_Telephone>
                </cit:phone>
              </xsl:if>
              <xsl:if test="normalize-space(FAXNUMBER)!=''">
                <cit:phone>
                  <cit:CI_Telephone>
                    <cit:number>
                      <gco:CharacterString>+61 2 6249 9960</gco:CharacterString>
                    </cit:number>
                    <cit:numberType>
                      <cit:CI_TelephoneTypeCode codeList="codeListLocation#CI_TelephoneTypeCode" codeListValue="facsimile">facsimile</cit:CI_TelephoneTypeCode>
                    </cit:numberType>
                  </cit:CI_Telephone>
                </cit:phone>
              </xsl:if>
              <xsl:if test="normalize-space(EMAILNAME)!=''">
                <cit:address>
                  <cit:CI_Address>
                    <cit:electronicMailAddress>
                      <gco:CharacterString><xsl:value-of select="EMAILNAME"/></gco:CharacterString>
                    </cit:electronicMailAddress>
                  </cit:CI_Address>
                </cit:address>
              </xsl:if>
            </cit:CI_Contact>
          </cit:contactInfo>
          </xsl:if>
          <xsl:if test="normalize-space(POSITION)!=''">
            <cit:positionName>
              <gco:CharacterString><xsl:value-of select="POSITION"/></gco:CharacterString>
            </cit:positionName>
          </xsl:if>
        </cit:CI_Individual>
      </cit:individual>
    </cit:CI_Organisation>

    </xsl:result-document>
   </xsl:for-each-group>
  </xsl:template>

</xsl:stylesheet>
