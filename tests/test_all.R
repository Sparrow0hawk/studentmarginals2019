# testing script
library(testthat)
library(here)
source(here('marginal-mapper','marginal-mapper-functions.R'))


test_that('test get_geojson', {
  
  sco_wpc <- get_geojson()
  
  expect_equal(as.character(sco_wpc$PCON13NM[1]), 'Aberdeen North')
})

test_that('test get_target', {
  
  data_path <- here("tests","testdata","test_target.csv")
  
  target_data <- get_targeting(data_path)
  
  expect_equal(as.character(target_data$Constituency[1]), 'Glasgow South West')
})

test_that('test get_myGeo', {
  
  load(here("src","data","environdata.Rdata"), envir=.GlobalEnv)
  
  test_geo <- get_myGeo('SW1A 0AA', key1)
  
  expect_equal(test_geo$status, "OK")
  
  expect_equal(test_geo$results$geometry$location$lat, 51.49984, tolerance = .0001)
  
  expect_equal(test_geo$results$geometry$location$lng, -0.124663, tolerance = .0001)
})

test_that('test determine_dist', {
  
  load(here('tests','testdata','testdist.Rdata'))
  
  test_frame <- read.csv(here("tests","testdata","test_target.csv"))
  
  dist_frame <- determine_dist(points_lst = test_addr,
                 wpc_geo = test_polygon,
                 target_data = test_frame)
  
  expect_equal(colnames(dist_frame), c('Constituency','MAJORITY','Link.to.doc',
                                       'Target.Hold','Labour.club','Distance from points'))
})


