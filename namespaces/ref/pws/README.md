ref/pws
===

Homepage:
* https://github.com/internetofwater/geoconnex.us/tree/master/namespaces/ref/

This is a reference collection of Public Water Systems. These features should be considered community cataloging features and can be referenced as such. 

The current implementation creating these ids and landing-content is in: https://github.com/ksonda/geoconnex_prep and hosted on
https://info.geoconnex.us/collections/pws. PIDs are based on the EPA SDWIS PWSID (STXXXXXXX)

The landing-content is based on Service Area Boundaries where available, which is currently:

 - AZ
 - CA
 - NC
 - NJ
 - NM
 - PA
 - TX
 - UT
 

Landing-content for everywhere else is based on the Census Place boundary if EPA SDWIS sepcifies the "CITY SERVED" and this name could be matched to the U.S. Census Places. If no such match was available, the centroid of the state in which the water system is.

The .gpkg source for the landing content is available [here.](https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/pws.gpkg)

Contacts: 
* Creator: <kyle.onda@duke.edu>
