#' Georgia Block Groups
#'
#' A spatial polygon dataset from the U.S. Census TIGER cartographic boundary files
#' (v2023). This dataset includes all 2020 block groups in the state of Georgia. Data
#' are projected in NAD83(CSRS) / UTM zone 19N.
#'
#' The dataset also includes a field containing total population counts from
#' 2023 American Community Survey (ACS) 5-Year Estimates.
#'
#' @format ## `gabgrps`
#' A spatial data frame with 7,441 rows and 5 columns:
#' \describe{
#'   \item{STATE}{State abbreviation}
#'   \item{GEOID}{12 digit unique identifier of the block group}
#'   \item{LSAD}{Year}
#'   \item{POP}{Estimate of total population}
#'   \item{geometry}{geometry}
#'   ...
#' }
#' @source [https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html]
#' @source [https://www.census.gov/programs-surveys/acs/data.html]
#'
#' @seealso
#' The script used to create the gabgrps dataset: [https://github.com/cdcent/hazprox/blob/main/data-raw/gabgrps.R]
#'
"gabgrps"


#' National Priority List/Superfund Sites
#'
#' A spatial points data frame containing National Priority List (otherwise known
#' as Superfund) sites in the state of Georgia or within 5 km of the state
#' boundary. Data are projected in NAD83(CSRS) / UTM zone 19N. Data were queried
#' from the EPA Envirofacts API on January 9, 2025.
#'
#' @format ## `npls`
#' A data frame with 17 rows and 13 columns:
#' \describe{
#'   \item{NAME}{Name of Superfund site}
#'   \item{EPA_ID}{A unique 12 digit identification number assigned by the Superfund Enterprise Management System}
#'   \item{SITE_ID}{Unique identifier for site for Superfunds with multiple sites}
#'   \item{STREET}{Street address of Superfund location}
#'   \item{ADDR_C}{Additional address information for Superfund location, if any}
#'   \item{CITY}{City/town/village/municipality of Superfund location or nearest place name if site is not within a formal jurisdiction.}
#'   \item{COUNTY}{County of Superfund location}
#'   \item{STATE}{State of Superfund location}
#'   \item{ZIP}{5-digit zip code of Superfund location}
#'   \item{DATE}{Date that information was queried from the EPA Envirofacts API}
#'   \item{geometry}{geometry}
#'   ...
#' }
#' @source https://enviro.epa.gov/
#' @seealso
#' The script used to create the npls dataset: [https://github.com/cdcent/hazprox/blob/main/data-raw/npls.R]
#'
#'
"npls"
