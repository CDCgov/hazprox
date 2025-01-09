#-------------------------------------------------------------------------------
# Creates a dataset for 2020 block groups in the state of Georgia. Data are
# queried from the U.S. Census Tiger Cartographic Boundary files (v2023).
# Population data from the 2023 American Community Survey are merged in.
#-------------------------------------------------------------------------------
library('sf')
library('dplyr')

#--------------------------------------------------------------------------------------
#Import census block group geography for Georgia
#--------------------------------------------------------------------------------------
gabgrps<-read_shape_URL('https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_13_bg_500k.zip')

#Project block polygons in the same CRS as the superfund layer
gabgrps <- st_transform(gabgrps, st_crs(npls))

#Merge population data to block groups
pop<-tidycensus::get_acs(geography = "block group",
                         survey = "acs5",
                         year=2023,
                         state = 'GA',
                         geometry = FALSE,
                         variables = c(total_pop='B02001_001')) %>%
  select (GEOID, POP=estimate)

gabgrps <- gabgrps %>% left_join(pop, join_by(GEOID))


#--------------------------------------------------------------------------------------
#Write Data
#--------------------------------------------------------------------------------------
gabrgps<-gabgrps %>%
  mutate(STATE='GA') |>
  select(STATE, GEOID, LSAD, POP, geometry)

usethis::use_data(gabgrps, overwrite = TRUE)
