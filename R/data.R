#' Georgia Census Tracts
#'
#' A spatial polygon dataset from the U.S. Census TIGER cartographic boundary files
#' (v2023). This dataset includes all 2020 census tracts in the state of Georgia. Data
#' are projected in NAD 1983 Georgia Statewide Lambert.
#'
#' The dataset also includes a field containing total population counts from
#' 2023 American Community Survey (ACS) 5-Year Estimates.
#'
#' @format ## `gabgrps`
#' A spatial data frame with 2,791 rows and 5 columns:
#' \describe{
#'   \item{STATE}{State abbreviation}
#'   \item{GEOID}{11-digit unique identifier of the tract}
#'   \item{LSAD}{Year}
#'   \item{POP}{Estimate of total population}
#'   \item{geometry}{geometry}
#'   ...
#' }
#' @source \url{https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html}
#' @source \url{https://www.census.gov/programs-surveys/acs/data.html}
#'
#' @seealso
#' The script used to create the ga dataset: \url{https://github.com/cdcent/hazprox/blob/main/data-raw/}
#'
"ga"


#' National Priority List/Superfund Sites
#'
#' A spatial points data frame containing National Priority List (otherwise known
#' as Superfund) sites in the state of Georgia or within 5 km of the state
#' boundary. Data are projected in NAD 1983 Georgia Statewide Lambert. Data were queried
#' from the EPA Envirofacts API on August 26, 2025.
#'
#' @format ## `npls`
#' A data frame with 17 rows and 13 columns:
#' \describe{
#'   \item{NAME}{Name of Superfund site}
#'   \item{EPA_ID}{A unique 12-digit identification number assigned by the Superfund Enterprise Management System}
#'   \item{SITE_ID}{Unique identifier for site for Superfunds with multiple sites}
#'   \item{STREET}{Street address of Superfund location}
#'   \item{ADDR_C}{Additional address information for Superfund location, if any}
#'   \item{CITY}{City/town/village/municipality of Superfund location or nearest place name if site is not within a
#'   formal jurisdiction.}
#'   \item{COUNTY}{County of Superfund location}
#'   \item{STATE}{State of Superfund location}
#'   \item{ZIP}{5-digit zip code of Superfund location}
#'   \item{DATE}{Date that information was queried from the EPA Envirofacts API}
#'   \item{geometry}{geometry}
#'   ...
#' }
#' @source \url{https://enviro.epa.gov/}
#' @seealso
#' The script used to create the npls dataset: \url{https://github.com/cdcent/hazprox/blob/main/data-raw/npls.R}
#'
#'
"npls"

#' Georgia Fire Locations
#'
#' This dataset includes a subset of records from the National Interagency Fire
#' Occurrence 6th Edition 1992-2020, published by the U.S. Forest Service. The
#' Georgia Fire Locations dataset, \strong{ga_fires.csv}, includes fires occurring
#' in the state of Georgia from 2016 through 2020.
#'
#' National Interagency Fire Occurrence records were acquired from the reporting
#' systems of federal, state, and local fire organizations. Data are
#' available for use under Creative Commons Attribution v4.0 License.
#'
#' @references
#' Short, Karen C. 2022. Spatial wildfire occurrence data for the United States, 1992-2020 (FPA_FOD_20221014).
#' 6th Edition. Fort Collins, CO: Forest Service Research Data Archive. https://doi.org/10.2737/RDS-2013-0009.6
#'
#'
#' @format ## `ga_fires`
#' A comma separated file with 16,195 rows and 11 columns:
#' \describe{
#'   \item{Id}{Unique identifier of the incident}
#'   \item{Name}{Descriptive name of fire}
#'   \item{Year}{Year of the incident discovery}
#'   \item{Date}{Date of incident discovery}
#'   \item{CauseType}{Reason the fire occurred (Human, Natural, Missing, Unknown)}
#'   \item{Event}{Event or circumstance that started or led to fire}
#'   \item{ControlDate}{Date fire was declared controlled or contained}
#'   \item{Acres}{Estimate of total area burned}
#'   \item{Owner}{Agency responsible for responding at origin}
#'   \item{Lat}{Latitude (NAD83) for point location of the fire (decimal degrees) }
#'   \item{Lon}{Longitude (NAD83) for point location of the fire (decimal degrees)}
#'   ...
#' }
#'
#' @source \url{https://catalog.data.gov/dataset/national-interagency-fire-occurrence-sixth-edition-1992-2020-feature-layer} #nolint
#' @source \url{https://www.fs.usda.gov/rds/archive/catalog/RDS-2013-0009.6}
#'
#' @seealso
#' The script used to create the ga_fires dataset: \url{https://github.com/cdcent/hazprox/blob/main/data-raw/ga-fires.R}
#'
"ga_fires"
