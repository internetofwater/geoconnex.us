FROM geopython/pygeoapi:latest

#Add data
RUN mkdir /data
#HU02 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/hu02.gpkg /data/
#HU04 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/hu04.gpkg /data/
#HU06 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/hu06.gpkg /data/
#HU08 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/hu08.gpkg /data/
#HU10 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/hu10.gpkg /data/
#nat_aq last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/nat_aq.gpkg /data/
#states last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/states.gpkg /data/
#counties last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/counties.gpkg /data/
#aiannh last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/aiannh.gpkg /data/
#cbsa last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/cbsa.gpkg /data/
#ua10 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/ua10.gpkg /data/
#places last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/places.gpkg /data/
#pws last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/pws.gpkg /data/
#ref_gages last updated 2021-06-04
ADD https://www.hydroshare.org/resource/4a22e88e689949afa1cf71ae009eaf1b/data/contents/ref_gages.gpkg /data/

#add requirements and mods
ADD https://raw.githubusercontent.com/webb-ben/pygeoapi/32982597267cc5c5faa2a110947d289f6eae38fb/pygeoapi/linked_data.py /pygeoapi/pygeoapi/linked_data.py
COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml
COPY ./schemas.opengis.net /opt/schemas.opengis.net
COPY ./pygeoapi-skin-dashboard /skin-dashboard
