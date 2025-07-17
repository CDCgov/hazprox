test_that("basic get_proximity works", {
  poly <- readRDS(test_path("testdata/poly.rds"))
  pts <- readRDS(test_path("testdata/pts.rds"))
  wts <- runif(nrow(pts), 0, 10)
  coords <- matrix(c(0, 0, 1, 0, 1, 1, 0, 1, 0, 0), ncol = 2, byrow = TRUE)
  m <- sf::st_polygon(list(coords))

  expect_silent(get_proximity(poly, pts))
  expect_silent(get_proximity(poly$geometry, pts))
  expect_silent(get_proximity(poly, poly$geometry))
  expect_silent(get_proximity(poly, pts, tolerance = 100))
  expect_silent(get_proximity(poly, pts, tolerance = 100, units = "km"))
  expect_silent(get_proximity(poly, pts, tolerance = 100, units = "km", weights = wts))
  expect_length(get_proximity(poly, pts), nrow(poly))

  expect_error(get_proximity(poly, pts, weights = wts[-1]), "`to` and `weights` must have the same length")
  expect_error(get_proximity(m, pts), "`from` must be a spatial polygon")
  expect_error(get_proximity(pts, poly), "`from` must be a spatial polygon")
})
