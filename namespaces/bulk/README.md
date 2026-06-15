# The Geoconnex Bulk Namespace

The `bulk` namespace in Geoconnex contains all integrations which are too large to be crawled as individual features. This may be due to rate limiting, an excessive amount of features which would be prohibitively long to crawl, or other stability issues with the source API. Instead of having a one entry in the sitemap for every feature, each bulk integration has a Docker container listed in its sitemap. One of such should be sufficient to provide data for the entire integration. This container can be ran by the Geoconnex crawler to get a list of JSON-LD documents output to standard out. Each JSON-LD document should represent a single feature or dataset. This pattern encapsulates all integration-specific logic while still providing the same sort of JSON-LD data we require for normal crawled sites. 

## Contributing Bulk Integrations

Documentation on how to add bulk integrations to Geoconnex can be found [here](https://docs.geoconnex.us/contributing/bulk/)