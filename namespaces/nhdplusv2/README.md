nhdplusv2
===

Homepage:
* https://www.epa.gov/waterdata/nhdplus-national-hydrography-dataset-plus

This namespace is used for NHDPlusV2 - based identifiers. In the context of geoconnex.us, the NHDPlusV2 dataset is treated like an organization because identifiers from datasets such as the NHD-Medium Resolution Reachcodes and WBD HUC12s are copied into NHDPlusV2 from a snapshot in time. These identifiers will be minted under this namespace.


Twelve digit hydrologic units:

* A snapshot of the Watershed Boundary Dataset is included in NHDPlusV2.
* https://geoconnex.us/nhdplusv2/huc12/070900020601

HUC12s currently redirect to a HUC12 outlet (pour point) feature in the Network Linked Data Index. In the future, this should redirect to a landing page that includes the boundary of the hydrologic unit.

NHDPlusV2 Common Identifiers:

* The "COMID" is a shared identifier for NHDPlus flowlines and catchments.
* https://geoconnex.us/nhdplusv2/comid/13293480

COMIDs currently redirect to a flowline representation of the identified catchment from the Network Linked Data Index. In the future, this should redirect to a more complete description of the catchment and associated data.

NHDPlusV2 Reachcodes

* Reachcodes identify collections of flowlines. They are commonly used in hydrographic addressing.
* https://geoconnex.us/nhdplusv2/reachcode/12040104000071

Redirects currently resolve a geojson representation of the reach.

NHDPlusV2 Waterbodies

* NHDPlusV2 waterbodies are a snapshot of the NHD Waterbodies layer included in the NHDPlusV2 dataset. Waterbody "comid" identifiers are used for the redirect.
* https://geoconnex.us//nhdplusv2/nhdwaterbody_comid/806161

Contacts:
* Creator <dblodgett@usgs.gov>
