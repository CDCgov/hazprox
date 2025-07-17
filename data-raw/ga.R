#-------------------------------------------------------------------------------
# Creates a dataset for 2020 census tracts in the state of Georgia. Data are
# queried from the U.S. Census Tiger Cartographic Boundary files (v2023).
# Population data from the 2023 American Community Survey are merged in.
#-------------------------------------------------------------------------------
library("sf")
library("dplyr")

#--------------------------------------------------------------------------------------
#Import census tract geography for state of Georgia
#--------------------------------------------------------------------------------------
read_shape_url <- function(x) {
  cur_tempfile <- tempfile()
  download.file(url = x, destfile = cur_tempfile)
  out_directory <- tempfile()
  unzip(cur_tempfile, exdir = out_directory)

  st_read(dsn = out_directory)
}

ga <- read_shape_url("https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_13_tract_500k.zip")

#Project tract polygons in the same CRS as the Superfund layer
ga <- st_transform(ga, st_crs(hazprox::npls))

#--------------------------------------------------------------------------------------
#Merge population data to block groups
#--------------------------------------------------------------------------------------
pop <- tidycensus::get_acs(geography = "tract",
                           survey = "acs5",
                           year = 2023,
                           state = "GA",
                           geometry = FALSE,
                           variables = c(total_pop = "B02001_001")) |>
  select(GEOID, POP = estimate)

ga <- ga |> left_join(pop, join_by(GEOID))


#--------------------------------------------------------------------------------------
#Write Data
#--------------------------------------------------------------------------------------
ga <- ga |>
  mutate(STATE = "GA") |>
  select(STATE, GEOID, LSAD, POP, geometry)

usethis::use_data(ga, overwrite = TRUE)
