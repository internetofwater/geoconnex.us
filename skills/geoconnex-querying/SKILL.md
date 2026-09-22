---
name: geoconnex-querying
description: Guidance for how to query the datasets present in the Geoconnex system, both the graph and the reference feature server. Use this to supplement context whenever the user makes an ambiguous or general inquiry about data in Geoconnex.
license: MIT
---

# Querying Geoconnex

Geoconnex refers to both a graph database and the overall infrastructure that provides it with data or presents it in other formats. There are multiple ways to retrieve data from within Geoconnex. Each has a different tradeoff.

1. The reference feature server https://reference.geoconnex.us/
2. The Geoconnex graph: https://graph.geoconnex.us
3. The Geoconnex OGC API features endpoint at https://features.geoconnex.us/collections/GeoconnexFeatures.  

## Reference Feature Serever

The reference feature server is located at https://reference.geoconnex.us/ and is an OGC API server running pygeoapi. It serves reference hydrologic boundary data for the US like HUCs, States, and Mainstems. It does not include data from external federal agencies (those are submitted as separate contributions to Geoconnex and hosted separately). It is an efficient and interoperables way to quickly load data from a specific reference boundary for GIS workflows. It is populated from gpkg/geojson data on hydroshare here: https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/ 

A list of all collections in the reference feature server OGC API can be found at: https://reference.geoconnex.us/collections/
To get the JSON-LD that populates the Geoconnex graph, you can look up a specific feature and then add `f=jsonld` to the end, that is what the Geoconnex crawler will harvest. https://reference.geoconnex.us/collections/states/items/20?f=jsonld

## Geoconnex Graph

The Geoconnex graph located at graph.geoconnex.us is the SPARQL endpoint to an RDF graph database. The graph is generally structured according the SHACL shape described in the docs here: https://docs.geoconnex.us/reference/data-formats/shacl_shape However, some user submitted datasets are outdated or structured incorrectly leading to isolated data in the graph.

The list of datasets that populate Geoconnex can be found in the sitemap here: https://geoconnex.us/sitemap.xml 

The Geoconnex graph is populated by either crawling persistent identifiers directly, or ingesting an entire dataset at once by using a Geoconnex bulk integration as described here: https://docs.geoconnex.us/contributing/bulk/ Bulk datasets may be slow to run but if you need to reproduce a specific dataset's RDF from within the graph, they can be ran directly. 

If you want to download a bulk nquad dump of the graph for local use you can use the OCI artifact export hosted on ghcr like this: `oras pull ghcr.io/internetofwater/geoconnex-graph:latest`

### Examples Queries

Geoconnex SPARQL queries link together a hydrologic feature with its associated geospatial or dataset relationships. The identifier used for the hydrologic feature is the `@id` in the harvested JSON-LD. The Geoconnex graph contains over 500 million triples with over 3.5 million geospatial features. As such, efficient production queries should use limits, filters, or other ways to prevent very large payloads. 

```sparql
#All datasets about the Animas River mainstem
PREFIX schema: <https://schema.org/>
PREFIX gsp: <http://www.opengis.net/ont/geosparql#>
PREFIX hyf: <https://www.opengis.net/def/schema/hy_features/hyf/>
SELECT DISTINCT ?monitoringLocation ?siteName ?datasetDescription ?type ?url
  ?variableMeasured ?variableUnit ?measurementTechnique ?temporalCoverage
  ?distributionName ?distributionURL ?distributionFormat ?wkt
  WHERE {
  VALUES ?mainstem { <https://geoconnex.us/ref/mainstems/35394> }

  ?monitoringLocation hyf:referencedPosition/hyf:HY_IndirectPosition/hyf:linearElement ?mainstem ;
  schema:subjectOf ?item ;
  hyf:HydroLocationType ?type ;
  gsp:hasGeometry/gsp:asWKT ?wkt .

  ?item schema:name ?siteName ;
  schema:temporalCoverage ?temporalCoverage ;
  schema:url ?url ;
  schema:variableMeasured ?variableMeasured .

  ?variableMeasured schema:description ?datasetDescription ;
  schema:name ?variableMeasuredName ;
  schema:unitText ?variableUnit ;
  schema:measurementTechnique ?measurementTechnique .

  OPTIONAL {
  ?item schema:distribution ?distribution .
  ?distribution schema:name ?distributionName ;
  schema:contentUrl ?distributionURL ;
  schema:encodingFormat ?distributionFormat .
  }

  # Filter datasets by the desired variable description
  FILTER(REGEX(?datasetDescription, "temperature", "i"))
}
ORDER BY ?siteName
```

```sparql
#Map all monitoring locations on the Snake River
PREFIX hyf: <https://www.opengis.net/def/schema/hy_features/hyf/>
PREFIX gsp: <http://www.opengis.net/ont/geosparql#>

SELECT DISTINCT ?monitoringLocation ?wkt
WHERE {
# Specify your desired mainstem 
VALUES ?mainstem { <https://geoconnex.us/ref/mainstems/35394> }

# Get monitoring locations along the mainstem
?monitoringLocation hyf:referencedPosition/hyf:HY_IndirectPosition/hyf:linearElement ?mainstem ;
	gsp:hasGeometry/gsp:asWKT ?wkt .
}
```

## https://features.geoconnex.us/collections/GeoconnexFeatures

https://features.geoconnex.us/collections/GeoconnexFeatures is an OGC API endpoint for all the geospatial features in Geoconnex, not just the reference boundaries contained within https://reference.geoconnex.us/ It may be referred to as the Geoconnex OGC API Features endpoint but this is not a canonical name. It uses pygeoapi with the postgres provider. It is the only collection in this OGC API endpoint. The goal of this endpoint is to discover features, not datasets or linked relationships. The feature IDs can then be used as an input to SPARQL queries if needed. The following properties may be present on a features: 

`id 	geoconnex_sitemap 	feature_name 	feature_description 	mainstem_uri`

The main benefit of this endpoint is that it supports the OGC CQL2 standard. This allows for sophisticated property or text filters that may have poor performance at scale in the https://graph.geoconnex.us endpoint. 

`https://features.geoconnex.us/collections/GeoconnexFeatures/items?bbox=-72.8,40.8,-68.8,47.7&mainstem_uri=https%3A%2F%2Fgeoconnex.us%2Fref%2Fmainstems%2F2290857&limit=100`
`https://features.geoconnex.us/collections/GeoconnexFeatures/items?filter=feature_name%20ILIKE%20%27reservoir%25%27&limit=1000`

If you want to download all of this data in bulk which totals nearly 4GB, you can use https://storage.googleapis.com/metadata-geoconnex-us/exports/geoconnex_features.parquet