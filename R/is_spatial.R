#' Function to verify that object is spatial data.
#'
#' @param x an object
#'
#' @return Returns True if object is spatial and False otherwise.
#' @export
is_spatial <- function(x){
  if (class(x)[1] == 'sf' | grepl("spatial", class(x)[1], ignore.case = TRUE)) TRUE else FALSE
}
