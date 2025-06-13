test_that("basic sync_projection works", {
  ga_2960 <- ga[1:10, ]
  ga_3857 <- sf::st_transform(ga[1:10, ], crs=3857)
  ga_gcrs <- sf::st_transform(ga[1:10, ], crs=4326)
  ga_none <- ga[1:10, ]
  sf::st_crs(ga_none) <-NA

  x = sync_projection(npls, ga_2960)
  y = sync_projection(npls, ga_gcrs)

  expect_equal(length(x), 2)
  expect_equal(sf::st_crs(x[1]), sf::st_crs(x[2]))
  expect_equal(length(y), 2)
  expect_equal(sf::st_crs(y[1]), sf::st_crs(y[2]))
  expect_error(sync_projection(npls, ga_3857), "Inputs have different projections. Transform data before proceeding.")
  expect_error(sync_projection(ga_gcrs, ga_gcrs), "The inputs do not have a projected CRS.")
  expect_error(sync_projection(ga_2960, ga_none), "Inputs must have a CRS")
})

test_that("Non-sf objects return error", {
  x = matrix(1:4, 2, 2)
  expect_error(sync_projection(npls, 2))
  expect_error(sync_projection(npls, "A"))
  expect_error(sync_projection(npls, x))
})
