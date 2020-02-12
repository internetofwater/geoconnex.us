# PID Service Backup Generator

This R package is to be used to generate XML backup files to upload new or modified PID redirects.

One function is exported by the package, `write_xml()`.

The package imports only the `xml2` package. This dependency may be removed in the future.

`write_xml()` takes two file paths, reading from a csv (or geojson in the future) and writing to an xml file.

```
write_xml("input_file_path.csv", "output_file_path.xml")
```
