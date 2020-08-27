Sitemap Preparation
================

This directory includes a [script](generate_sitemap.R) that:

1. Collates all PIDs listed in contributed CSV files
1. Retrieves lists of PIDs that are represented in the PIDsvc with regex redirects from geospatial source files
1. Generates sitemap.xml files with 1,000 URLs each for submission to search engines in the directory [/xml1k](xml1k)
1. Generates a sitemap index file [sitemapindex1k.xml](sitemapindex1k.xml) that lists the sitemap.xml files in /xml1k for submission to search engines
1. Generates a [zipped master_sitemap.xml](master_sitemap.zip) with all URLs for use in Project Geoconnex R&D on crawlers and metadata catalogs.
