#' Ensures that spatial data are in same projected coordinate system.
#'
#' @param df1 An object of class sf of sfc
#' @param df2 An object of class sf of sfc
#' @return A list object containing both spatial data frames projected in the same CRS.
#'
#' @importFrom glue glue
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
    stop("Error: The data are not in a projected CRS.\n")
  }

  #Check if inputs projected in the same CRS
  else if (!sf::st_is_longlat(df1) && !sf::st_is_longlat(df2) &&
           sf::st_crs(df1)!=sf::st_crs(df2)) {
    stop("Error: Input data are not in the same projected CRS.\nTransform your data before proceeding.\n")
  }

  #if a single input is projected, project other input in same CRS
  else if (!sf::st_is_longlat(df1) && sf::st_is_longlat(df2)) {
    message(glue("{df2_name} is not in a projected CRS.
                 Projecting {df2_name} into ({sf::st_crs(df1)$proj4string}).\n"))
    df2 <- df2 |> sf::st_transform(crs=sf::st_crs(df1))
  }

  #if a single input is projected, project other input in same CRS
  else if (sf::st_is_longlat(df1) && !sf::st_is_longlat(df2)) {
    message(glue("{df1_name} is not in a projected CRS.
                 Projecting {df1_name} into ({sf::st_crs(df2)$proj4string}).\n"))
    df1 <- df1 |> sf::st_transform(crs=sf::st_crs(df2))
  }

  else {
    message("Data are projected in same CRS.")

  }

  return(list(df1 = df1, df2 = df2))
}
