library(sf)
library(dplyr)
library(glue)
#-------------------------------------------------------------------------------
#Function to ensure polygon and points are in same projected coordinate system
#-------------------------------------------------------------------------------
#' @export
sync_projection<-function(df1, df2){

  df1_name <- deparse(substitute(df1))
  df2_name <- deparse(substitute(df2))

  #Check if inputs in geographic CRS
  if (st_is_longlat(df1) & st_is_longlat(df2)) {
    stop("Error: The data are not in a projected CRS.\n")
  }

  #Check if inputs projected in the same CRS
  else if (!st_is_longlat(df1) & !st_is_longlat(df2) &
           st_crs(df1)!=st_crs(df2)) {
    stop("Error: The data are not in the same projected CRS.\nTransform your data before proceeding.\n")
  }

  #if a single input is projected, project other input in same CRS
  else if (!st_is_longlat(df1) & st_is_longlat(df2)) {
    message(glue("{df2_name} is not in a projected CRS.
                 Projecting {df2_name} into ({st_crs(df1)$proj4string}).\n"))
    df2 <- df2 |> st_transform(crs=st_crs(df1))
  }

  #if a single input is projected, project other input in same CRS
  else if (st_is_longlat(df1) & !st_is_longlat(df2)) {
    message(glue("{df1_name} is not in a projected CRS.
                 Projecting {df1_name} into ({st_crs(df2)$proj4string}).\n"))
    df1 <- df1 |> st_transform(crs=st_crs(df2))
  }

  else {
    message("Data are projected in same CRS.")

  }

  return(list(df1 = df1, df2 = df2))
}
