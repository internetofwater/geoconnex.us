<?xml version="1.0" encoding="UTF-8" ?>

<!--
    GMLJP2 2.1 example with a referenceable grid coverage (gmljp2:GMLJP2ReferenceableGridCoverage)
    having an instantiable referenceable grid element (gmlcovrgrid:ReferenceableGridBySensorModel) in
    its domain set. The sensorModel of the referenceable grid element is set by xlink reference.
    while the sensorInstance of the referenceable grid element is embedded SensorML 2.0.
	The sensorModel and sensorInstance make use of the minimal encodings of the CSM frame camera
	metadata profile put together by Mike Botts for the SensorML 2.0 RFC. (A nearly complete
	SensorML 2.0 encoding may be found at http://gmljp2.aeroptic.com)
-->

<gmljp2:GMLJP2CoverageCollection gml:id="ID_Collection_0"
        xmlns="http://www.opengis.net/gml/3.2"
        xmlns:gmlcovrgrid="http://www.opengis.net/gmlcov/gmlcovrgrid/1.0"
        xmlns:gmljp2="http://www.opengis.net/gmljp2/2.1"
        xmlns:gmlcov="http://www.opengis.net/gmlcov/1.0"
        xmlns:gml="http://www.opengis.net/gml/3.2"
        xmlns:swe="http://www.opengis.net/swe/2.0"
        xmlns:sml="http://www.opengis.net/sensorml/2.0"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.opengis.net/gmljp2/2.1 http://schemas.opengis.net/gmljp2/2.1/gmljp2.xsd">
    <gml:domainSet nilReason="inapplicable"/>
    <gml:rangeSet>
		<gml:DataBlock>
			<gml:rangeParameters nilReason="inapplicable"/>
			<gml:doubleOrNilReasonTupleList>inapplicable</gml:doubleOrNilReasonTupleList>
		</gml:DataBlock>
    </gml:rangeSet>
    <gmlcov:rangeType>
		<swe:DataRecord>
			<swe:field name="Collection"> </swe:field>
		</swe:DataRecord>
    </gmlcov:rangeType>
    <gmljp2:featureMember>
        <gmljp2:GMLJP2ReferenceableGridCoverage gml:id="ID_Coverage_0">
            <domainSet>
                <gmlcovrgrid:ReferenceableGridBySensorModel gml:id="ID_SensorModel_0" dimension="2"
						srsDimension="3" srsName="http://www.opengis.net/def/crs/EPSG/0/4979">
                    <limits>
                        <GridEnvelope>
                            <low>0 0</low>
                            <high>6731 8983</high>
                        </GridEnvelope>
                    </limits>
                    <axisLabels>Row Column</axisLabels>
                    <gmlcovrgrid:sensorModel xlink:href="http://www.sensorml.com/sensorML-2.0/examples/csmFrame.html"/>
                    <gmlcovrgrid:sensorInstance>
                        <sml:SimpleProcess gml:id="myKCM-HD-camera">
                            <gml:description>
                                An example of an instance of the Community Sensor Model for precise geolocation of the HD UAV-borne video KCM-HD camera
                            </gml:description>
                            <gml:identifier codeSpace="uid">urn:myDomain:swe:csm:KCM-HD</gml:identifier>
                            <sml:typeOf xlink:title="urn:net:swe:process:csmFrameCamera2"
                                        xlink:href="http://www.sensorml.com/sensorML-2.0/examples/csmFrame.html"/>
                            <sml:configuration>
                                <sml:Settings>
                                    <sml:setValue ref="parameters/csmParams/focalLength">51.5465</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/focalLength/quality">5.512e-003</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/pixelGridCharacteristics/numberOfRowsInImage">6732</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/pixelGridCharacteristics/numberOfColumnsInImage">8984</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/pixelGridCharacteristics/rowSpacing">0.0074</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/pixelGridCharacteristics/columnSpacing">0.0074</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/principalPointCoordinates/x0">-0.1608</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/principalPointCoordinates/x0/quality">4.353e-003</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/principalPointCoordinates/y0">0.0979</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/principalPointCoordinates/y0/quality">5.059e-003</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/affineDistortionCoefficients/a1">0.0</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/affineDistortionCoefficients/b1">-4.94883e-025</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/affineDistortionCoefficients/b1/quality">1.419e-016</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/affineDistortionCoefficients/c1">0</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/affineDistortionCoefficients/a2">0</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/affineDistortionCoefficients/b2">-1.42380e-025</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/affineDistortionCoefficients/b2/quality">1.419e-016</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/affineDistortionCoefficients/c2">0</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/radialDistortionCoefficients/k1">3.34076e-005</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/radialDistortionCoefficients/k1/quality">1.036e-006</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/radialDistortionCoefficients/k2">1.64705e-007</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/radialDistortionCoefficients/k2/quality">1.735e-008</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/radialDistortionCoefficients/k3">2.10952e-022</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/radialDistortionCoefficients/k3/quality">1.419e-016</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/decenteringCoefficients/p1">-2.30790e-025</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/decenteringCoefficients/p1/quality">1.419e-016</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/decenteringCoefficients/p2">-4.27963e-025</sml:setValue>
                                    <sml:setValue ref="parameters/csmParams/decenteringCoefficients/p2/quality">1.419e-016</sml:setValue>
                                </sml:Settings>
                            </sml:configuration>
                        </sml:SimpleProcess>
                    </gmlcovrgrid:sensorInstance>
                </gmlcovrgrid:ReferenceableGridBySensorModel>
            </domainSet>
            <rangeSet>
                <File>
                    <rangeParameters />
                    <fileName>gmljp2://codestream</fileName>
                    <fileStructure>inapplicable</fileStructure>
                    <mimeType>image/jp2</mimeType>
                </File>
            </rangeSet>
            <gmlcov:rangeType>
                <swe:DataRecord>
					<swe:field name="Color">
						<swe:Quantity definition="http://www.opengis.net/def/ogc-eo/opt/SpectralMode/COLOR">
							<swe:description>Color RGB</swe:description>
							<swe:uom code="unity"/>
						</swe:Quantity>
					</swe:field>
                </swe:DataRecord>
            </gmlcov:rangeType>
        </gmljp2:GMLJP2ReferenceableGridCoverage>
    </gmljp2:featureMember>
</gmljp2:GMLJP2CoverageCollection>
