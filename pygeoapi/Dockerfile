FROM internetofwater/pygeoapi:latest
#pygeoapi last updated 2022-05-16

#Add data directory
RUN mkdir /data

#HU02 last updated 2021-06-04 15:36:00 UTC-5
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/hu02.gpkg /data/
#HU04 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/hu04.gpkg /data/
#HU06 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/hu06.gpkg /data/
#HU08 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/hu08.gpkg /data/
#HU10 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/hu10.gpkg /data/
#nat_aq last updated 2022-04-08
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/nat_aq.gpkg /data/
#states last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/states.gpkg /data/
#counties last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/counties.gpkg /data/
#aiannh last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/aiannh.gpkg /data/
#cbsa last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/cbsa.gpkg /data/
#ua10 last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/ua10.gpkg /data/
#places last updated 2021-06-04
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/places.gpkg /data/
#pws last updated 2022-09-28
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/ref_pws.gpkg /data/
#ref_gages last updated 2022-06-03
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/ref_gages.gpkg /data/
#mainstems last updated 2023-02-06
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/mainstems.gpkg /data/
#secondary hydrogeologic regions last updated 2022-04-08
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/sec_hydrg_reg.gpkg /data/
#principal aquifers last updated 2022-04-11
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/princi_aq.gpkg /data/
#gages last updated 2022-12-07
ADD https://www.hydroshare.org/resource/3295a17b4cc24d34bd6a5c5aaf753c50/data/contents/ref_dams.gpkg /data

#add requirements and mods
COPY ./pygeoapi.config.yml /pygeoapi/local.config.yml
# COPY ./schemas.opengis.net /opt/schemas.opengis.net
COPY ./pygeoapi-skin-dashboard /skin-dashboard
