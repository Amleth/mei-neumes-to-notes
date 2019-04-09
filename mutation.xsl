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
                    <xsl:for-each select=".//mei:syllable/mei:neume">
                        <xsl:for-each select="mei:nc">
                            <note dur="4" stem.len="0">
                                <xsl:copy-of select="@*"/>
                                <xsl:if test="position()=1">
                                    <verse>
                                        <xsl:copy select="../../mei:syl">
                                            <xsl:copy-of select="@*"/>
                                            <xsl:value-of select="."/>
                                        </xsl:copy>
                                    </verse>
                                </xsl:if>
                            </note>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:copy>
            </xsl:copy>
            <xsl:for-each select=".//mei:syllable/mei:neume">
                <xsl:if test="count(./mei:nc) > 1">
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
                </xsl:if>
            </xsl:for-each>
        </measure>
    </xsl:template>
</xsl:stylesheet>