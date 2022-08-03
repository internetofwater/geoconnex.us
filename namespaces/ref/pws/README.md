ref/pws
===

Homepage:
* https://github.com/internetofwater/geoconnex.us/tree/master/namespaces/ref/

This is a reference collection of Public Water Systems. These features should be considered community cataloging features and can be referenced as such. 

The current implementation creating these ids and landing-content is in: https://github.com/cgs-earth/ref_pws and hosted on
https://reference.geoconnex.us/collections/pws. PIDs are based on the EPA SDWIS PWSID (STXXXXXXX)

The landing content is based on data available from EPA SDWIS. The geometries are generally based on those curated by SimpleLab Inc, with methodology described at https://github.com/SimpleLab-Inc/wsb and summarized briefly below.

In general, this methodology includes Service Area Boundaries where widely available, which is currently:

 - AZ
 - CA
 - CT
 - IL
 - KS
 - MO
 - NC
 - NJ
 - NM
 - OK
 - PA
 - TX
 - UT
 - WA
 

Geometry for everywhere else is based on the Census Place boundary if EPA SDWIS specifies the "CITY SERVED" and this name could be matched to the U.S. Census Places. If no such match was available, facility locations from EPA ECHO were used to generate a notional centroid location.

Additionally, service area boundaries are directly contributed by the community via pull request to https://github.com/cgs-earth/ref_pws

The .gpkg source for the landing content is available [here.](https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/ref_pws.gpkg)

Contacts: 
* Creator: <konda@lincolninst.edu>
