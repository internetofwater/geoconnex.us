Permanent Identifiers for US Hydrologic Features
================================================

This is the registry for URIs with the base https://geoconnex.us, principally to assign permanent identifiers and redirects for hydrologic features in the United States as an implementation [Internet of Water](https://www.aspeninstitute.org/tag/internet-of-water/) principles. Persistent identifiers are important for maintaining a production system of linked hydrologic data systems, of the sort that [SELFIE](https://github.com/opengeospatial/SELFIE) experimented. 

Adding a Permanent Identifier to geoconnex.us
=========================================
The process for adding a URI is similar to that used by [w3id.org](https://github.com/perma-id/w3id.org)

The preferred way to create the redirects yourself is by following these steps:

1. Fork the [`internetofwater/geoconnex.us`](https://github.com/internetofwater/geoconnex.us) repository.
2. Add a directory corresponding to the namespace you want. For example '/example-namespace/
3. Add a set of redirects using the [csv template](https://github.com/internetofwater/geoconnex.us/blob/master/example-namespace/example_ids.csv) or a geojson file with the same attributes.

  * The only required fields are "id" (the geoconnex URI you want), "target" (where the URI should redirect to), and "creator" (your email address).
  * Optionally include latitude and longitude, lines, or polygons in a geojson file to refer to resources about places with distinct locations on Earth.
  * Optionally include more complex redirects for content negotiarion using the c1_ and c2_ fields.

4. (Optional) Add a `README.md` detailing contact persons and 
   (a subset of) your permanent identifiers in your namespace directory. For an example, 
   see [`example-namespace/README.md`](example-namespace/README.md)
5. Commit your changes and submit a 
   [pull request](https://github.com/internetofwater/geoconnex.us/pulls).
6. geoconnex.us administrators will review your pull request and merge it if 
   everything looks correct. Once the pull request is merged, the changes go
   live within (a time period)

