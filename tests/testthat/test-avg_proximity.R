test_that("basic avg_proximity works", {
  poly <- readRDS(test_path("testdata/poly.rds"))
  pts <- readRDS(test_path("testdata/pts.rds"))
  pwts <- sample(500:5000, (nrow(poly)))
  prox <- get_proximity(poly, pts)

  expect_silent(avg_proximity(poly, pts, group = "STATE"))
  expect_s3_class(avg_proximity(poly, pts, group = "STATE"), 'sf')
  expect_equal(avg_proximity(poly, pts, group = "STATE")$avg_prox, mean(prox))
  expect_silent(avg_proximity(poly, pts, group = "STATE", pop_weights = pwts))

  expect_error(avg_proximity(poly, pts), "argument \"group\" is missing, with no default")
  expect_error(avg_proximity(poly, pts, group = "STATE", pop_weights = pwts[-1]), "Error: `from` and `pop_weights` must have same length.")

})
