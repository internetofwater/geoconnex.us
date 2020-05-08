# https://info.geoconnex.us pygeoapi configuration

The geoconnex reference data server is a work in progress based on the [pygeoapi project.](https://pygeoapi.io/)

The server configuration can be found in [pygeoapi.config.yml](pygeoapi.config.yml)

Data hosted by the server can be found in [ext-data](ext-data)

## Contributing new content

Three pieces of information are required for a new contribution:  
1. spatial feature geometry and attributes in [ext-data](ext-data)
1. a pygeoapi resource configuration in [pygeoapi.config.yml](pygeoapi.config.yml)
1. PIDs registered with the `geoconnex.us` pid server for the features

### Spatial Features
Spatial feature data should be contributed in `geojson` format and be optimized for simple web-preview. This means the geometry should be simplified as much as is practical and attributes should be useful to a general audience.

At a minimum, the features should include attributes containing a name for the features and the PIDs of the features. The PIDs should be in an attribute titled `uri`. 

### pygeoapi configuration

See existing datasets for sample configuration. The configuration should include some JSON context configuration that associate attributes of the data to JSON-ld properties. This might look like:

```
        context:
            - name: https://schema.org/name
            - url: https://schema.org/subjectOf
            - description: https://schema.org/description
            - uri: "@id"
```

The `uri` element is required and ensures that the attributes get associated with the feature's PID rather than the URL of the https://info.geoconnex.us reference data server.

Many other context elements are possible. The [ELFIE project](https://opengeospatial.github.io/ELFIE/) has focused on that topic and can be a source of inspiration.

It is expected that the attributes and richness of these contexts will expand over time but getting some basic content in the system is better than nothing, so please don't hesitate to get something started and open a pull request. The geoconnex crew is more than happy to help get things across the finish line!

### PIDs for features

The features hosed in the https://info.geoconnex.us are intended to provide landing pages for PIDs registered in the `https://geoconnex.us/ref/` namespace, more info on those features can be found [here](https://github.com/internetofwater/geoconnex.us/tree/master/namespaces/ref)

These reference features are intended to be ["community reference locations"](https://github.com/internetofwater/geoconnex.us/wiki/Community-Reference-Locations) and will be created based on broadly-recognized reference data or by a community group interested in registering a wholistic set of reference identifiers that unify multiple organization's identifiers of a similar type. Please [open a new general issue](https://github.com/internetofwater/geoconnex.us/issues/new?template=general.md&title=%5Bgeneral%5D) to discuss an idea for a new set of reference identifiers.

## Install

```
svn checkout https://github.com/internetofwater/geoconnex.us/trunk/pygeoapi
cd pygeoapi
mkdir schemas.opengis.net
cd schemas.opengis.net
curl -O http://schemas.opengis.net/SCHEMAS_OPENGIS_NET.zip  && unzip SCHEMAS_OPENGIS_NET.zip
cd ..
docker-compose up -d
```
