#' @title avg_proximity
#'
#' @description
#' Function to calculate average proximity to environmental hazards within a specified area.
#' The function will calculate a population weighted average if the user supplies a vector
#' of population counts or weights.

#' @param from A spatial polygon layer with class sf or sfc. Proximity is calculated from
#' the geometric center of each polygon to each hazard within the search tolerance.
#' @param to A spatial polygon, point, or linestring layer with class sf or sfc
#' representing the environmental hazard(s) of interest.
#' @param ... Additional parameters
#' @param group Name of grouping variable in the `from` layer. Average proximity is calculated
#' among polygons nested in the group.
#' @param pop_weights An optional vector of population weights if weighted-averages are desired.
#'
#' @importFrom rlang .data
#'
#' @examples
#' #find average census tract proximity to Superfund sites by county
#' ga$County <- substr(ga$GEOID, 1, 5)
#' counties <- avg_proximity(ga, npls,  group='County')
#' plot(counties['avg_prox'])
#' #find population-weighted average tract proximity to Superfund sites by county
#' counties_wt <- avg_proximity(ga, npls,  group='County', pop_weights = ga$POP)
#'
#' @export
avg_proximity <- function(from, to, ...,  group, pop_weights=NULL) {

  #Verify that weights are provided for each unit, if any
  if(!is.null(pop_weights) && nrow(from) != length(pop_weights)) {
    stop('Error: `from` and `pop_weights` must have same length.')
  }

  #Calculate proximity for each unit of from_poly
  from$unit_prox <- get_proximity(from, to, ...)

  #Calculated weighted average, ignore missing values
  if(!is.null(pop_weights)) {
    result <- from |>
      cbind(pop_weights = pop_weights) |>
      dplyr::group_by(!!!rlang::syms(group)) |>
      dplyr::summarise(avg_prox = sum(.data$pop_weights  * .data$unit_prox, na.rm=T) /
                         sum(.data$pop_weights, na.rm=T))
  }

  if(is.null(pop_weights)) {
     result <- from|>
      dplyr::group_by(!!!rlang::syms(group)) |>
      dplyr::summarise(avg_prox = mean(.data$unit_prox, na.rm=T))
  }

  return(result)

}
