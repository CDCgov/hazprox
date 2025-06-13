#' Confirms that spatial data are in same projected coordinate system. Transforms unprojected input
#' into the projected coordinate reference system of the other input, if defined.
#'
#' @param df1 An object of class sf of sfc
#' @param df2 An object of class sf of sfc
#' @return A list object containing both spatial data frames projected in the same CRS.
#'
#' @importFrom glue glue
#' @examples
#' x = sf::st_polygon(list(rbind(c(33.9, -84.1),
#'                               c(33.9, -84.0),
#'                               c(34.0, -84.0),
#'                               c(34.0, -84.1),
#'                               c(33.9, -84.1))))
#' y = sf::st_point(c(34.1, -84))
#' x = sf::st_sfc(x, crs=4326)
#' y = sf::st_sfc(y, crs=4326)
#' #transform y into Albers Equal Area Conic projection
#' y = sf::st_transform(y, crs = 5070)
#' result <- sync_projection(x, y)
#' plot(result[[1]], ylim = c(6510000, 6550000), col = NA, border = 'red')
#' plot(result[[2]], add = TRUE, col =  'blue')
#'
#'
#' @export
sync_projection<-function(df1, df2){

  #Check that inputs are both simple feature objects
  stopifnot("Inputs must be an sf, sfc, or sfg object" =
              inherits(df1, c('sf', 'sfc', 'sfg')) &&
              inherits(df2, c('sf', 'sfc', 'sfg')))

  #Verify that both objects have a coordinate reference system
  stopifnot("Inputs must have a CRS" =
              !is.na(sf::st_crs(df1)) &&
              !is.na(sf::st_crs(df2)))

  df1_name <- deparse(substitute(df1))
  df2_name <- deparse(substitute(df2))

  #Check if inputs in geographic CRS
  if (sf::st_is_longlat(df1) && sf::st_is_longlat(df2)) {
    stop("The inputs do not have a projected CRS.\n")
  }

  #Check if inputs projected in the same CRS
  else if (!sf::st_is_longlat(df1) && !sf::st_is_longlat(df2) &&
           sf::st_crs(df1)!=sf::st_crs(df2)) {
    stop("Inputs have different projections. Transform data before proceeding.\n")
  }

  #if a single input is projected, project other input in same CRS
  else if (!sf::st_is_longlat(df1) && sf::st_is_longlat(df2)) {
    message(glue("{df2_name} does not have a projected CRS.
                 Projecting {df2_name} into ({sf::st_crs(df1)$proj4string}).\n"))
    df2 <- df2 |> sf::st_transform(crs=sf::st_crs(df1))
  }

  #if a single input is projected, project other input in same CRS
  else if (sf::st_is_longlat(df1) && !sf::st_is_longlat(df2)) {
    message(glue("{df1_name} does not have a projected CRS.
                 Projecting {df1_name} into ({sf::st_crs(df2)$proj4string}).\n"))
    df1 <- df1 |> sf::st_transform(crs=sf::st_crs(df2))
  }

  #else {
  #  message("Data are projected in same CRS.")

  #}

  return(list(df1 = df1, df2 = df2))
}
