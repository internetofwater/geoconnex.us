# Permanent Identifiers (PIDs) for US Hydrologic Features
================================================

This is the registry for PIDs with the base https://geoconnex.us, principally to assign permanent identifiers and redirects for hydrologic features in the United States as an implementation [Internet of Water](https://github.com/opengeospatial/SELFIE/blob/master/docs/demo/internet_of_water.md) principles. Persistent identifiers are important for maintaining a production system of linked hydrologic data systems, of the sort that [SELFIE](https://github.com/opengeospatial/SELFIE) experimented, in order to reduce the problem of broken links when data publishers change URLs.

### See the [Wiki](https://github.com/internetofwater/geoconnex.us/wiki) for more details on participating!

## Adding Permanent Identifiers to geoconnex.us

The process for adding a PID-URI redirect is generally similar to that used by [w3id.org](https://github.com/perma-id/w3id.org).

There is a strong preference for creating "[1:1](#adding-11-redirects-to-geoconnexus)" redirects. That is, specifying an exact redirect from a geoconnex.us-based PID to the URI of the hydrologic feature you have a web resource about, for each and every individual feature. However, if you need to create PIDs and redirects for a large number of features (>= 10,000), we will require a [regular expression matching redirect](#adding-regular-expression-redirects-to-geoconnexus). For example, redirecting from https://geoconnex.us/example-namespace/*wildcard-string to https://example.org/features?query=*wildcard-string. 

That being said, 1:1 redirects are preferred where possible because they are simpler to resolve and allow you to customize (and change, when needed) your target URI patterns with more specificity. Thus, if you have >=10,000 features, but these features can be split in a consistent way into sub-collections, all of which number <10,000 features (as might be the case for features that can be divided by geography, jurisdiction, theme, or type), then you might consider submitting multiple collections of 1:1 redirects.

### Adding 1:1 redirects to geoconnex.us


The preferred way to create the redirects yourself is by following these steps:

1. Fork the [`internetofwater/geoconnex.us`](https://github.com/internetofwater/geoconnex.us) repository.
2. Add a directory corresponding to the namespace you want in the `namespaces` directory. For example 'namespaces/example-namespace/
3. Add a set of redirects using the [csv template](https://github.com/internetofwater/geoconnex.us/blob/master/namespaces/example-namespace/example_ids.csv) or a geoJSON file with the exact same field names as the csv template. You may consider adding multiple separate sets of redirects, as long as each set is comprised of <=10,000 

  * The only required fields are "id" (the geoconnex URI you want), "target" (where the URI should redirect to), and "creator" (your email address).
  * Optionally include latitude and longitude, lines, or polygons in a geojson file to refer to resources about places with distinct locations on Earth.
  * Optionally include more complex redirects for content negotiation using the c1_ and c2_ fields.

4. (Optional but strongly suggested) Add a `README.md` detailing contact persons and 
   (a subset of) your permanent identifiers in your namespace directory. For an example, 
   see [`namespaces/example-namespace/README.md`](namespaces/example-namespace/README.md)
5. Commit your changes and submit a 
   [pull request](https://github.com/internetofwater/geoconnex.us/pulls).
6. geoconnex.us administrators will review your pull request and merge it if 
   everything looks correct. Once the pull request is merged, the changes go
   live within (a time period)

### Adding regular expression redirects to geoconnex.us

If you have a collection of >10,000 features that cannot be easily and consistently subdivided, please submit a request for a regular expression redirect. To do so, you may [create an issue of type "Request regex redirect"](https://github.com/internetofwater/geoconnex.us/issues/new?assignees=dblodgett-usgs%2C+ksonda&labels=PID+request&template=request-regex-redirect.md&title=[regex+redirect+request) and fill out the template.

![](https://internetofwater.org/wp-content/uploads/2019/12/iow_logo_horizontal_rgb_TM_header.png)![](https://prd-wret.s3.us-west-2.amazonaws.com/assets/palladium/production/s3fs-public/styles/full_width/public/thumbnails/image/USGS_logo_green_SQUARE.png)