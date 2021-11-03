![logo](https://user-images.githubusercontent.com/44071350/111527969-eb43b980-8736-11eb-82ca-3418b045df4b.png)


# Permanent Identifiers (PIDs) for US Hydrologic Features

This is the registry for PIDs with the base https://geoconnex.us, principally to assign permanent identifiers and redirects for hydrologic and other spatial features in the United States as an implementation of [Internet of Water](https://github.com/opengeospatial/SELFIE/blob/master/docs/demo/internet_of_water.md) principles.

The `https://geoconnex.us` project is intentionally incremental -- seeking to build useful capabilities incrementally as we scale up adoption and capabilities. The project's success is contingent on broad contribution and adoption. See [the contributing guidelines](https://github.com/internetofwater/geoconnex.us/blob/master/CONTRIBUTING.md) for more.

## Why geoconnex.us?

Persistent identifiers are important for maintaining a system of linked environmental data systems in order to reduce the problem of broken links when data publishers change URLs and maintain the integrity of search indexes built by web crawlers.

The value of `https://geoconnex.us` can be illustrated considering two use cases:

1. Indexing and discovering models and research from public sector, private sector, or academic projects about a particular place or environmental feature.  
1. Building a federated multi-organization monitoring network in which all member-systems reference common monitored features and are discoverable through a community index.

See [https://geoconnex.us/demo](https://geoconnex.us/demo) for a mockup of data discovery and access workflows that `https://geoconnex.us` aspires to enable.

These use cases imply requirements that `https://geoconnex.us` helps satisfy:

1. A shared reference network of environmental features.
1. The ability to use the reference network to index and provide access to information resources from many organizations.
1. Support for multiple disciplines' information models, conceptual models, research topics, and monitoring practices.

`https://geoconnex.us` seeks to achieve these goals with sustainable and automatable solutions to link multi-disciplinary, multi-organization environmental data without the requirement to transfer custody or burden of maintenance of data.

`https://geoconnex.us` is built on [W3C best practices](https://www.w3.org/TR/sdw-bp/), providing guidance and a common approach for encoding environmental feature data and links between and among features and observational data about them.

`https://geoconnex.us` is intended to satisfy the needs of many use cases and many kinds of features, from disaster response and resilience to environmental health and the built environment.

## Features in `https://geoconnex.us`

The features registered in `https://geoconnex.us` are either community reference features or associated with a particular organization or database.

1. community reference features: monitoring and environmental features collated by a person or group in the interest of the community
1. organization specific features: features owned by a particular organizational entity or from a specific dataset

These features can also be described using their role in the linked-data system.

1. Monitoring: locations at which organizations monitor the environment.
1. Cataloging: environmental, jurisdictional, or hydrologic units that can be used to group and sort data.
1. Environmental: real-world features that are the subject of monitoring.

Features are registered in the [namespaces](https://github.com/internetofwater/geoconnex.us/tree/master/namespaces) folder. Namespaces contains organizations, datasets, and a special `https://geoconnex.us/ref` namespace reserved for community reference features not owned by a single organization.

**See the [OGC API Features](https://reference.geoconnex.us/) for the reference features hosted by geoconnex.us**

## Geoconnex.us-related presentations and publications.
- [National Hydrography Infrastructure and Geoconnex](https://drive.google.com/file/d/1J0NKYOq3pGjQXr58FKO8sd7uHpGA8kNB/view?usp=sharing)
- [New Mexico Water Data Initiative including geoconnex.us](https://webresources.internetofwater.us/presentations/geoconnex%20federal.pptx)
- [Roundtable presentation including geoconnex.us](https://www.westernstateswater.org/wp-content/uploads/2020/06/CO_Roundable_IoW.pdf)
- [Second Environmental Linked Features Interoperability Experiment](https://github.com/opengeospatial/SELFIE)
- [ESIP Sessions on Structured Data in the Web](https://2020esipsummermeeting.sched.com/event/cIvv/structured-data-on-the-web-putting-best-practice-to-work) [slides](https://docs.google.com/presentation/d/1LSXHz2_Y7hrkGZPC_sNoJWl8AIujI8AAWktl9amIR4E/edit#slide=id.g8250495469_1_30)

## [Guidance for contributing PIDs and reference features is available here.](https://github.com/internetofwater/geoconnex.us/blob/master/CONTRIBUTING.md)

## License

[![CC0](https://i.creativecommons.org/p/zero/1.0/88x31.png)](https://creativecommons.org/publicdomain/zero/1.0/)

The contents of the geoconnex.us project are [public domain](https://creativecommons.org/publicdomain/zero/1.0/). All contributors to the project dedicate their contribution to the public domain. For more information, see [LICENSE.md](LICENSE.md).

[![](https://internetofwater.org/wp-content/uploads/2019/12/iow_logo_horizontal_rgb_TM_header.png)](https://internetofwater.org/)[![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/USGS_logo_green.svg/320px-USGS_logo_green.svg.png)](https://www.usgs.gov/mission-areas/water-resources)
