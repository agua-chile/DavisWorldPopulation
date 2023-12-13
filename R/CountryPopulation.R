#' Country Population.
#'
#' This function takes in a string of a country name and returns a graph of its
#' population data from the dataset World_Population from this package.
#'
#' @param countryName - a name of a country
#' @return ggplot graph of that country's population data
#' @examples
#' CountryPopulation( "China" )
#' CountryPopulation( "Italy" )
#' @export

CountryPopulation <- function( countryName )
{
  found <- FALSE
  for( i in 1:234 )
  {
    if( countryName == World_Population$`Country Name`[i] )
    {
      found <- TRUE
      break
    }
  }
  if( !found )
  {
    stop( 'The country entered is not valid!' )
  }
  return(
    World_Population %>%
      pivot_longer(
        `1950`:`2020`,
        names_to = 'Year',
        values_to = 'Population'
      ) %>%
      filter( str_detect( `Country Name`, countryName ) ) %>%
      mutate_at( vars( matches( 'Year' ) ), as.numeric ) %>%
      ggplot( aes( Year, Population ) ) +
      geom_line() +
    labs( title=countryName, x='Year', y='Population' )
  )
}
