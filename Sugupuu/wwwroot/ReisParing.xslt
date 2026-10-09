<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">
		<table border="1"  width="700">
			<thead>
			<tr>
				<th>Nimetus</th>
				<th>Riik</th>
				<th>Pikkus</th>
				<th>Transport</th>
				<th>Hinnang</th>
				<th>Reisihind</th>
			</tr>
			</thead>
			<tbody>
			<xsl:for-each select="reisid/reis/suund">
				<xsl:sort select ="Pikkus" data-type="number" order="descending"/>
				<tr align="center">
					<td align="left">
						<xsl:value-of select="Nimetus"/>
					</td>
					<td>
						<xsl:value-of select="Riik"/>
					</td>
					<td>
						<xsl:value-of select="Pikkus"/>
					</td>
					<td>
						<xsl:value-of select="transport"/>
					</td>
					<td>
						<xsl:value-of select="hinnang"/>
					</td>
					<td>
						<xsl:value-of select="reisihind"/>
					</td>
				</tr>
			</xsl:for-each>
			</tbody>
		</table>

		<br/>
		<h1>
			<strong>Kõik suunad: </strong>
			<xsl:for-each select ="reisid/reis/suund">
				<xsl:value-of select="Riik"/>,
			</xsl:for-each>
		</h1>

		<ul>
			<xsl:for-each select ="reisid/reis/suund">
				<li>
					<xsl:attribute name="style">
						background-color: yellow;
					</xsl:attribute>
					<xsl:value-of select="concat(Riik, ', ', Pikkus, ' päeva , ', Nimetus)"/>,

				</li>
			</xsl:for-each>

			<xsl:for-each select ="reisid/reis/suund">
				<li>
					<xsl:value-of select="concat(Riik,' - ', Pikkus, ' päeva')"/>
					<xsl:if test="Pikkus > 7">
						- Pikk reis

					</xsl:if>
				</li>
			</xsl:for-each>
		</ul>

		<strong>Kogumaksumus </strong>
		<xsl:value-of select="sum(reisid/reis/suund/reisihind)"/> eurot
		<br /><br />
		<strong>Transport</strong>
		<ul>
			<xsl:for-each select ="reisid/reis/suund">
				<xsl:if test="transport = 'Lennuk'">
					<li>
						<xsl:value-of select="concat(Nimetus,', ', Riik, ', Transport: ',  transport)"/>
					</li>
				</xsl:if>
			</xsl:for-each>
		</ul>

		<strong>Sorteeri reisid kestvuse järgi.</strong>
		<ul>
			<xsl:for-each select ="reisid/reis/suund">
				<xsl:sort select="Pikkus" order="descending"/>
				<li>
					<xsl:value-of select="concat(Nimetus, ', ', Riik, ', Hind: ', reisihind)"/>
				</li>
			</xsl:for-each>

		</ul>
	</xsl:template>
</xsl:stylesheet>
