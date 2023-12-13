# Check to see if I get the same values in CountryPopulation
test_that('Unrestricted Poisson values correct', {
  expect_error( CountryPopulation( 'Unertid Sterts uv Umerika' ),  'The country entered is not valid!' )
})
