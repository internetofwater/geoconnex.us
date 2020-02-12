test_that("basic make mapping", {
  out <- write_xml("data/chyld_test.csv", tempfile(fileext = ".xml"))

  check <- xml2::as_list(xml2::read_xml(out))

  expect_equal(check$backup[[1]]$path[[1]],
               "/chyld-pilot/id/hu/041504030301-drainage_basin_flowpath")

  expect_equal(check$backup[[1]]$description[[1]], "made for GSIP / CHyLD pilot project testing")

  expect_equal(check$backup[[1]]$action$value[[1]],
               "https://cida-test.er.usgs.gov/chyld-pilot/info/hu/041504030301-drainage_basin_flowpath")

  expect_equal(check$backup[[1]]$conditions[[1]]$actions[[1]]$value[[1]],
               "https://cida-test.er.usgs.gov/chyld-pilot/info/hu/041504030301-drainage_basin_flowpath?f=${C:f:1}&callback=${C:callback:1}&_=${C:_:1}")

  expect_equal(attr(check$backup, "xmlns"), "urn:csiro:xmlns:pidsvc:backup:1.0")
})
