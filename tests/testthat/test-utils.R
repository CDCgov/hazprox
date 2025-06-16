test_that("multiplication works", {
  expect_type(to_km(1, 'mi'), 'double')
  expect_equal(to_km(1, 'mi'), 1.609344)
  expect_equal(to_km(1, 'in'), 0.0000254)
  expect_equal(to_km(1, 'ft'), 0.0003048)
  expect_identical(to_km(1, 'yd'), to_km(1, 'yard'))
  expect_error(to_km(1, 'blah'))
})
