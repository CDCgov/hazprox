## code to prepare `npls` dataset goes here

#-------------------------------------------------------------------------------
# Creates a dataset to containing information about Superfund sites in
# the state of Georgia. Data are queried from the EPA envirofacts API.
#-------------------------------------------------------------------------------
library('sf')
library('dplyr')
library('httr') #query EPA envirofacts api to pull Superfund site data
library('jsonlite') #parse envirofacts data

#-------------------------------------------------------------------------------
# Build buffer around state(s) of interest to filer Superfund sites of interest.
# We'll include all Superfunds within state boundaries and those within 5 km
# of the state border.
#-------------------------------------------------------------------------------
read_shape_URL <- function(URL){
  cur_tempfile <- tempfile()
  download.file(url = URL, destfile = cur_tempfile)
  out_directory <- tempfile()
  unzip(cur_tempfile, exdir = out_directory)

  st_read(dsn = out_directory)
}

state_data <- read_shape_URL('https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_us_state_500k.zip')

#filter the state boundary files to Georgia project
state_temp <- state_data |>
  filter(STUSPS %in% c('GA')) |>
  st_transform(crs=2960) #Albers Equal Area projection

#Create 5 km buffer around states
state_buf<- st_buffer(state_temp, dist=5000)

#-------------------------------------------------------------------------------
# Import Superfund Site from EPA Envirofacts RESTful API
# See data model: https://enviro.epa.gov/envirofacts/metadata/model
# and keep sites that are located within state buffer
#-------------------------------------------------------------------------------

npl_query <- function(status, states, buffer) {

  #Get Superfund data from EPA Envirofacts API
  request <- GET(
    paste(
      'https://data.epa.gov/efservice/sems.envirofacts_site',
      'npl_status_code/in', status,
      'fk_ref_state_code/in', states,
      sep = '/')
  )

  #Convert json data to R data frame
  df <- fromJSON(content(request, "text"))

  #Format coordinates and transform to multipoint spatial data
  df <- df |>
    mutate(lat = as.numeric(gsub("+", "", primary_latitude_decimal_val)),
           lon = as.numeric(primary_longitude_decimal_val)) |>
    st_as_sf(coords = c('lon', 'lat'), crs=4326)

  #Keep sites that are within buffer
  df <- df |>
    st_transform(crs=st_crs(buffer)) |>
    st_filter(buffer)

  #Add date of data pull
  df <- df |>
    mutate(DATE = Sys.Date())

  #Output spatial data
  return(df)
}

npls<- npl_query(states = 'GA', status = 'F', buffer=state_buf)

#View spatial data
plot(state_buf$geometry, col='navy')
plot(state_temp$geometry, col='white', add=T)
plot(npls$geometry, col='red', cex=1, pch=8, add=T)

#--------------------------------------------------------------------------------------
# Write Data
#--------------------------------------------------------------------------------------

npls<-npls |>
  select(
    NAME=name,
    EPA_ID=epa_id,
    SITE_ID=site_id,
    STREET=street_addr_txt,
    ADDR_C=supplemental_addr_txt,
    CITY=city_name,
    COUNTY=county_name,
    STATE=fk_ref_state_code,
    FED_FAC=federal_facility_ind,
    STATUS=npl_status_code,
    ZIP=zip_code,
    DATE,
    geometry)

usethis::use_data(npls, overwrite = TRUE)
