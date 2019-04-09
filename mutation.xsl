<?xml version="1.0"?>
<xsl:stylesheet version="3.0" expand-text="yes" exclude-result-prefixes="mei" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:mei="http://www.music-encoding.org/ns/mei">
    <xsl:strip-space elements="*"/>
    <xsl:mode on-no-match="shallow-copy" />
    <xsl:template match="mei:staff">
        <measure xmlns="http://www.music-encoding.org/ns/mei">
            <xsl:copy select=".">
                <xsl:copy-of select="@*"/>
                <xsl:copy select="./mei:layer">
                    <xsl:copy-of select="@*"/>
                    <xsl:for-each select=".//mei:syllable/mei:neume/mei:nc">
                        <note>
                            <xsl:copy-of select="@*"/>
                        </note>
                    </xsl:for-each>
                </xsl:copy>
            </xsl:copy>
            <xsl:for-each select=".//mei:syllable/mei:neume">
                <slur>
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:attribute name="startid">
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="mei:nc[1]/@xml:id"/>
                    </xsl:attribute>
                    <xsl:attribute name="endid">
                        <xsl:text>#</xsl:text>
                        <xsl:value-of select="mei:nc[position()=last()]/@xml:id"/>
                    </xsl:attribute>
                </slur>
            </xsl:for-each>
        </measure>
    </xsl:template>
</xsl:stylesheet>