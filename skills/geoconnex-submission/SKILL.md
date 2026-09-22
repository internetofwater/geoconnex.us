---
name: geoconnex-submission
description: Guidance for how to add a new dataset into the Geoconnex system. Description of both crawlable and bulk integrations for Geoconnex, how to create them, and the tradeoffs of each. Use this to supplement context whenever the user makes an ambiguous or general inquiry about how to add data to Geoconnex or create a bulk integration.
license: MIT
---

# Submitting to Geoconnex

Geoconnex has 2 main methods of submission. Both are tracked and approved by maintainers via GitHub pull requests to https://github.com/internetofwater/geoconnex.us 

1. Bulk integrations (Recommended)
2. Live crawlable HTML / JSON-LD landing pages

Both methods of submission must have an associated `metadata.json` file using this schema: https://raw.githubusercontent.com/internetofwater/geoconnex.us/refs/heads/master/checks/geoconnex_metadata_schema.json which describes info like who maintains it and how it should be ingested into the Geoconnex system. An example can be found here:  https://raw.githubusercontent.com/internetofwater/geoconnex.us/refs/heads/master/namespaces/wwdh/usace/metadata.json

It must also have a redirect `.csv` file that handles how to map the Geoconnex PID to the source system. Example: https://raw.githubusercontent.com/internetofwater/geoconnex.us/refs/heads/master/namespaces/wwdh/awdb_forecasts/awdb_forecasts.csv These CSV files may specify either a 1:1 mapping or a regex redirect. Use 1:1 for small datasets, regex for large ones above a few thousand features.

The RDF data from harvesting a submission should comply with the Geoconnex SHACL shape described here: https://docs.geoconnex.us/reference/data-formats/shacl_shape

##  Bulk integrations 

The requirements for Geoconnex bulk integrations are described in the docs here: https://docs.geoconnex.us/contributing/bulk/ An example can be found here: https://github.com/internetofwater/usgs_monitoring_locations_bulk_exports

Bulk integrations live in a public git repo with an associated public Docker image that when ran outputs newline delimited JSON-LD to standard out that complies with the Geoconnex SHACL shape. This method of submission is recommended for most situations. It typically doesn't require an organization to spin up new infrastructure and the bulk container workflow can choose how to process and generate the RDF data most efficiently. It just requires that the user's data can be retrieved publicly somehow from within the container. Data that the container ingests and processes could be hosted in Github releases, a live web API, hydroshare, an S3 bucket etc.

Depending on the user's tolerance for complexity, it may make sense to put a cached version of intermediary ETL artifacts (Geoparquet, etc.) into GitHub releases or other public infrastructure to speed up the crawl time.

## Crawlable Landing Pages

Crawlable landing pages are described in the docs here: https://docs.geoconnex.us/contributing/api/ 
Each feature gets a unique PID and that PID is then used to populate a sitemap XML file like the following: https://geoconnex.us/sitemap/ref/states.xml

Crawlable landing pages with embedded JSON-LD or content negotiation are easy to understand for users, but struggle at scale. Many servers rate limit crawling and organizations lack long term maintenance funding. Before creating such an integration, ensure the user's endpoint will not struggle or block a fetch request to each feature. 