# This example creates one redirect with two conditions.
# Specific names are not used by the write_xml function
# The first four columns are required. Sequences of
# "type", "match", and "value" are written into rewrite
# rule conditions.

example_file <- "example_ids.csv"
example_out <- "example_ids.xml"

example <- data.frame(id = "https://geoconnex.us/example",
                      target = "https://geoconnex.internetofwater.dev",
                      creator = "dblodgett@usgs.gov",
                      description = "This is an example PID with two conditions",
                      c1_type = "QueryString",
                      c1_match = "f?=.*",
                      c1_value = "https://geoconnex.internetofwater.dev?f=${C:f:1}",
                      c2_type = "Extension",
                      c2_match = "^.html$",
                      c2_value = "https://geoconnex.internetofwater.dev.html",
                      stringsAsFactors = FALSE)

write.csv(example, example_file, row.names = FALSE)

pidsvcBackup::write_xml(example_file, example_out)
