# Sciencebase Bulk Integration

This integration provides a bulk export of [USGS sciencebase](https://www.sciencebase.gov/catalog/) in rdf format. It enumerates all datasets with their associated geospatial metadata and download links. It sources the data from the sciencebase API [here](https://www.sciencebase.gov/catalog/items?q=&filter=systemType%3DData+Release&format=json&max=1000) and then fetches the JSON for each dataset in the response.

The source code for this integration can be found [here](https://github.com/internetofwater/sciencebase_bulk_rdf)

Contacts:
* Creator: Colton Loftus, <cloftus@lincolninst.edu>
