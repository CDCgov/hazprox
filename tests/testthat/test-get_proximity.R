test_that("basic get_proximity works", {
  ga <- ga[1:10,]
  pts <- npls[1:10, ]
  wts <- runif(10, 0, 10)
  coords <- matrix(c(0, 0, 1, 0, 1, 1, 0, 1, 0, 0), ncol = 2, byrow = TRUE)
  m <- sf::st_polygon(list(coords))

  expect_silent(get_proximity(ga, pts))
  expect_silent(get_proximity(ga, pts, tolerance = 100))
  expect_silent(get_proximity(ga, pts, tolerance = 100, units = 'km'))
  expect_silent(get_proximity(ga, pts, tolerance = 100, units = 'km', weights = wts))
  expect_length(get_proximity(ga, pts), 10)

  expect_error(get_proximity(ga, pts, weights = wts[-1]), "`to` and `weights` must have the same length")
  expect_error(get_proximity(coords, pts), '`from` must be a spatial polygon')
  expect_error(get_proximity(pts, ga), '`from` must be a spatial polygon')
})
