# USGS Monitoring Locations Bulk Integration

This namespace provides bulk integration for USGS Monitoring Locations. Although USGS already provides a feature level landing pages with JSON-LD for crawling monitoring locations, this integration allows the Geoconnex crawler to reduce the number of HTTP requests needed to download all locations from the USGS and thus speed up the crawl / reduce errors. Since this integration uses the [USGS OGC API endpoint](api.waterdata.usgs.gov/ogcapi/v0/collections/monitoring-locations/) directly it also brings in additional metadata about the associated timeseries parameters.

The source code for the Docker container can be found [here](https://github.com/internetofwater/usgs_monitoring_locations_bulk_exports). This integration works by first creating an intermediary geoparquet file, caching that in Github releases, and then applying a JSON-LD template to every row in the geoparquet file.

Contacts:
* Creator: Colton Loftus, <cloftus@lincolninst.edu>
