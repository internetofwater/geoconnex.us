![logo](https://user-images.githubusercontent.com/44071350/111527969-eb43b980-8736-11eb-82ca-3418b045df4b.png)


# About the project

The Geoconnex project is about providing technical infrastructure and guidance to create an open, community-contribution model for a knowledge graph linking hydrologic features in the United States, published in accordance with [Spatial Data on the Web best practives](https://www.w3.org/TR/sdw-bp/) as an implementation of [Internet of Water](https://github.com/opengeospatial/SELFIE/blob/master/docs/demo/internet_of_water.md) principles.

In short, Geoconnex aims to make water data as easily discoverable, accessible, and usable as possible.

## What is Geoconnex?

Geoconnex aims to enable a [knowledge graph](https://en.wikipedia.org/wiki/Knowledge_graph) for water data in the United States. The value of this graph, (see `https://graph.geoconnex.us`) can be illustrated considering two use cases:

1. Indexing and discovering models and research from public sector, private sector, or academic projects about a particular place or environmental feature.  
1. Building a federated multi-organization monitoring network in which all member-systems reference common monitored features and are discoverable through a community index.

See [https://geoconnex.us/demo](https://geoconnex.us/demo) for a mockup of data discovery and access workflows that `https://geoconnex.us` aspires to enable. 

Architecturally, Geoconnex involves:

1. A set of community-curated web resources about hydrologic *reference features* (e.g. watersheds, monitoring locations, dams, bridges, etc.) about which many organizations may collect and publish data. 
1. Web resources about hydrologic features that organizations publish on the web, including embedded JSON-LD metadata, using common ontologies such as [schema.org](https://schema.org), and domain-specific ontologies such as [HY-Features](https://www.opengis.net/def/schema/hy_features/hyf) for hydrology and [SOSA/SSN](https://www.w3.org/TR/vocab-ssn/) for sensor data. Guidance for embedded JSON-LD is under development at [docs.geoconnex.us](https://github.com/internetofwater/docs.geoconnex.us)
1. A registry of persistent identifiers (PIDs) that point to the above resources. The PIDs in the geoconnex system have the base URI `https://geoconnex.us/`.  Learn how to submit identifiers for the registry here: [CONTRIBUTING](CONTRIBUTING.md). PIDs are important to maintain so that data publishers can change the URLs of their web resources while the knowledge graph and any search engine remain functional (preventing [link rot](https://en.wikipedia.org/wiki/Link_rot)). 
1. A harvester that collects the JSON-LD published above, and publishes the resulting knowledge graph as both a public domain data product and an open API, allowing for the building of search interfaces. The harvester codebase is under development at [harvest.geoconnex.us](https://github.com/internetofwater/harvest.geoconnex.us), and the knowledge graph itself will be available from [graph.geoconnex.us](https://graph.geoconnex.us)

See the figure below:
<img width="1230" alt="image" src="https://user-images.githubusercontent.com/44071350/149584683-48c60f86-1f53-4ad3-a2d0-458a9dcf3150.png">


## What is in graph.geoconnex.us?

The features registered in `https://geoconnex.us` are automatically harvested and included in [graph.geoconnex.us](https://graph.geoconnex.us) are either community reference features or associated with a particular organization or database.

1. community reference features: monitoring and environmental features collated by a person or group in the interest of the community. These features are available via OGC API Features at [reference.geoconnex.us](https://reference.geoconnex.us/collections). See this [R Shiny application](https://internetofwater.shinyapps.io/geoconnex-reference-features) for a simple map-based search interface for reference features.
1. organization specific features: features owned by a particular organizational entity or from a specific dataset. 


## Geoconnex.us-related presentations and publications.
- [National Hydrography Infrastructure and Geoconnex](https://drive.google.com/file/d/1J0NKYOq3pGjQXr58FKO8sd7uHpGA8kNB/view?usp=sharing)
- [New Mexico Water Data Initiative including geoconnex.us](https://docs.google.com/presentation/d/1yuNpBbQPcmb_Nw8DXiuNTazAjIM8UF7o/edit?usp=sharing&ouid=102421334323378854304&rtpof=true&sd=true)
- [Roundtable presentation including geoconnex.us](https://www.westernstateswater.org/wp-content/uploads/2020/06/CO_Roundable_IoW.pdf)
- [Second Environmental Linked Features Interoperability Experiment](https://github.com/opengeospatial/SELFIE)
- [ESIP Sessions on Structured Data in the Web](https://2020esipsummermeeting.sched.com/event/cIvv/structured-data-on-the-web-putting-best-practice-to-work) [slides](https://docs.google.com/presentation/d/1LSXHz2_Y7hrkGZPC_sNoJWl8AIujI8AAWktl9amIR4E/edit#slide=id.g8250495469_1_30)

## [Guidance for contributing PIDs and reference features is available here.](https://github.com/internetofwater/geoconnex.us/blob/master/CONTRIBUTING.md)

## License

[![CC0](https://i.creativecommons.org/p/zero/1.0/88x31.png)](https://creativecommons.org/publicdomain/zero/1.0/)

The contents of the geoconnex.us project are [public domain](https://creativecommons.org/publicdomain/zero/1.0/). All contributors to the project dedicate their contribution to the public domain. For more information, see [LICENSE.md](LICENSE.md).

[![](https://internetofwater.org/wp-content/uploads/2019/12/iow_logo_horizontal_rgb_TM_header.png)](https://internetofwater.org/)[![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/USGS_logo_green.svg/320px-USGS_logo_green.svg.png)](https://www.usgs.gov/mission-areas/water-resources)
