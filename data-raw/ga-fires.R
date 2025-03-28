#-------------------------------------------------------------------------------
# Creates a dataset for fires occurring in the state of Georgia between 2011
# and 2020. Data are queried from the National Interagency Fire Occurrence 6th
# Edition 1992-2020 (Feature Layer). The wildfire records were acquired from the
# reporting systems of federal, state, and local fire organizations. Data are
# available for use under Creative Commons Attribution v4.0 License.

# CITATION:
# Short, Karen C. 2022. Spatial wildfire occurrence data for the United States, 1992-2020
# [FPA_FOD_20221014]. 6th Edition. Fort Collins, CO: Forest Service Research Data Archive.
# https://doi.org/10.2737/RDS-2013-0009.6
#
# See https://catalog.data.gov/dataset/national-interagency-fire-occurrence-sixth-edition-1992-2020-feature-layer/resource/184a26f3-ba25-47f8-8788-505e647edea8
#-------------------------------------------------------------------------------
library('sf')
library('dplyr')

#Import data from data.gov repository

url<-'https://data-usfs.hub.arcgis.com/api/download/v1/items/1f4a85fa0cc749fcabc35672f94cf410/csv?layers=29'

file_name <- "National Interagency Fire Occurrence Sixth Edition 1992-2020 (Feature Layer).csv"
file_path <- "C://Users//ppk8//Downloads//"

download.file(url = url, destfile = paste0(file_path, file_name, sep = ""))
fires <- read.csv(file = paste0(file_path, file_name))

#Select fires occurring in Georgia from 2011 through 2020
ga_fires <- fires |> filter(STATE == 'GA' & FIRE_YEAR > 2010)

#Select variables for analysis
ga_fires <- ga_fires |>
  select(Id = FOD_ID, #UNIQUE ID
         Source = SOURCE_SYSTEM_TYPE, #REPORTING SOURCE TYPE
         Name = FIRE_NAME, # NAME OF INCIDENT
         Year= FIRE_YEAR, # YEAR OF DISCOVERY
         Date = DISCOVERY_DATE, # DATE OF DISCOVERY
         CauseType = NWCG_CAUSE_CLASSIFICATION, # Reason the fire occurred (Human, Natural, Missing, Unknown).
         Event = NWCG_GENERAL_CAUSE, #Event or circumstance that started or led to fire
         ControlDate = CONT_DATE, #Date fire was controlled
         Acres = FIRE_SIZE, #Estimate of total area burned
         Lat = LATITUDE,
         Lon = LONGITUDE,
         Owner = OWNER_DESCR #Agency responsible for responding at origin
  )

#--------------------------------------------------------------------------------------
#Write Data
#--------------------------------------------------------------------------------------
write.csv(ga_fires, "inst/extdata/ga_fires.csv", row.names = FALSE)

