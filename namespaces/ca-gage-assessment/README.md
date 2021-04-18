ca-gage-assessment
===

Homepage:
* https://github.com/internetofwater/CA-Gages

This namespace is used for identifiers associated with the [California SB19 streamgage network planning process](https://leginfo.legislature.ca.gov/faces/billTextClient.xhtml?bill_id=201920200SB19) being undertaken by the California Water Boards and Department of Water Resources. It will eventually include identifiers
for all  streamgages in California to be integrated into the public streamgage network (eventually to be consolidated into [CDEC](https://cdec.water.ca.gov/)) as well as features such as watersheds and other 
geographies of interest that may have attributes of interest for streamgage network planning. All features will eventually be represented from a variety of sources in a dedicated data server, for now at https://sb19.linked-data.internetofwater.dev

### Gage Site IDs:

The "Site ID" is a shared identifier for cataloged streamgages. There is a hierarchy of identifiers used for cataloged gages in the case of duplicated sites. USGS/NWIS site numbers take first priority, followed by NOAA/HADS identifiers, followed by CDEC station codes, followed by the identifier schemes of any local government or nongovernmental gages identified as part of the SB19 process.  This catalog is available as an [ESRI feature service](https://gispublic.waterboards.ca.gov/portal/home/item.html?id=32dfb85bd2744487affe6e3475190093). It is represented as an OGC API Collection at https://sb19.linked-data.internetofwater.dev/collections/ca_gages

Examples:
* An a gage in NWIS: https://geoconnex.us/ca-gage-assessment/gages/09429490
* A gage in HADS, but not NWIS: https://geoconnex.us/ca-gage-assessment/gages/CE51E94A
* A gage in CDEC, but not HADS or NWIS: https://geoconnex.us/ca-gage-assessment/gages/ABJ

Contacts: 
* Creator <kyle.onda@duke.edu> (to be handed over to CA staff)
