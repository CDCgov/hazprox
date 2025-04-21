#' @title avg_proximity
#'
#' @description
#' Function to calculate average proximity to point-source
#' environmental hazards within a specified area. The function
#' will calculate a population weighted average if the user
#' supplies a vector of population counts or weights.

#' @param from_poly A spatial polygon layer
#' @param to_points A spatial points layer that represents the
#' environmental hazards.
#' @param tolerance The maximum search distance for environmental hazards.
#' @param group Name of variable in the from_poly layer that defines the group means
#' are calculated for.
#' @param pop_weights An optional vector of population weights if
#' weighted-averages are desired.
#'
#' @importFrom rlang .data
#'
#' @export
avg_proximity <- function(from_poly, to_points, tolerance, group, pop_weights=NULL) {

  #Verify that weights are provided for each unit, if any
  if(!is.null(pop_weights) && nrow(from_poly) != length(pop_weights)) {
    stop('Error: from_poly and pop_weights must have same length.')
  }

  #Calculate proximity for each unit of from_poly
  from_poly$unit_prox <- get_proximity(
        from = from_poly,
        to = to_points,
        tolerance = tolerance
        )

  #Calculated weighted average, ignore missing values
  if(!is.null(pop_weights)) {
    result <- from_poly |>
      cbind(pop_weights = pop_weights) |>
      dplyr::group_by(!!!rlang::syms(group)) |>
      dplyr::summarise(avg_prox = sum(.data$pop_weights  * .data$unit_prox, na.rm=T) /
                         sum(.data$pop_weights, na.rm=T))
  }

  if(is.null(pop_weights)) {
     result <- from_poly|>
      dplyr::group_by(!!!rlang::syms(group)) |>
      dplyr::summarise(avg_prox = mean(.data$unit_prox, na.rm=T))
  }

  return(result)

}
