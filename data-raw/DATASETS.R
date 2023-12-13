World_Cup_Data <- read_html( 'https://en.wikipedia.org/wiki/FIFA_World_Cup' ) %>%
  html_nodes( 'table' ) %>%
  .[[4]] %>%
  html_table( header=FALSE, fill=TRUE ) %>%
  magrittr::set_colnames( c( 'Year', 'Hosts', 'Venues/Cities',
                             'Totalattendance', 'Matches',
                             'Averageattendance',
                             'Highest Attendance Number',
                             'Highest Attendance Venue',
                             'Highest Attendance Game(s)' ) ) %>%
  slice( -1 * 1:2 ) %>%
  select( Year, Hosts, Matches, Totalattendance, Averageattendance ) %>%
  mutate_at( vars( matches( 'attendance|Matches' ) ), str_remove_all, ',' ) %>%
  mutate_at( vars( matches( 'attendance|Matches' ) ), as.numeric) %>%
  slice_min( Year, n=22 ) %>%
  mutate( WorldCup = paste( Hosts, Year, sep='' ) ) %>%
  select( WorldCup, Matches, Totalattendance, Averageattendance )

World_Population <- read_excel( 'data-raw/World_Population.xlsx', sheet='ESTIMATES', skip=16 ) %>%
  filter( !str_detect( `Region, subregion, country or area *`, "[Dd]evel|WORLD|income|region|SUB|Oceania|Africa|Europe|LATIN|Asia|NORTH|SOUTH|Northern|Caribbean|AUSTRALIA|Melanesia|Micronesia|EUROPE" )) %>%
  mutate( `Country Name` = `Region, subregion, country or area *` ) %>%
  select( `Country Name`, matches( '19|20' ) ) %>%
  mutate_at( vars( matches( '19|20' ) ), as.numeric )

usethis::use_data( World_Cup_Data )
usethis::use_data( World_Population )
