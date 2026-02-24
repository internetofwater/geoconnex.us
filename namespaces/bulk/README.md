# The Geoconnex Bulk Namespace

The `bulk` namespace in Geoconnex contains all integrations which are too large to be crawled as individual features. This may be due to rate limiting, an excessive amount of features which would be prohibitively long to crawl, or other stability issues with the source API. Instead of having a one entry in the sitemap for every feature, each bulk integration has a Docker container listed in its sitemap. While more than one can be listed, one is generally sufficient to provide data for the entire integration. This container can be ran by the Geoconnex crawler to get a list of JSON-LD documents output to standard out. Each JSON-LD document should represent a single feature or dataset. This pattern encapsulates all integration-specific logic while still providing the same sort of JSON-LD data we require for normal crawled sites. 

## Contributing Bulk Integrations

To contribute bulk integrations to Geoconnex you must:

1. Create a docker container pushed to a public container registry like dockerhub or ghcr
2. Ensure the docker container outputs nothing but newline delimited JSON-LD documents to standard out when ran without any arguments
3. Submit a PR to `namespaces/bulk/${YOUR_INTEGRATION_NAME}` with an `.xml` sitemap structured analogous to the following

```xml
<?xml version='1.0' encoding='utf-8'?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
    xmlns:geoconnex="http://geoconnex.us/schemas/sitemap">
    <url>
        <loc>internetofwater/gnis_bulk_rdf:latest</loc>
        <lastmod>2025-02-05T16:39:34Z</lastmod>
        <geoconnex:type>bulk</geoconnex:type>
    </url>
</urlset>
```