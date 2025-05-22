#' @title get_proximity
#'
#' @description
#' Calculate the cumulative proximity to environmental hazards for geographic areas.
#' The function calculates the sum of inverse distances between the geometric center
#' of the area and all hazards within a specified tolerance. Proximity calculations
#' for areas that do not have any hazards within the specified tolerance only consider the single
#' nearest distance. A vector of weights may be applied to each hazard so that
#' some hazards contribute more to the cumulative proximity score.

#' @param from An spatial polygon layer with class sf or sfc. Proximity
#' statistics will be calculated for each polygon in this layer.
#' @param to A spatial polygon, point, or linestring layer with class sf or sfc
#' representing the environmental hazard(s) of interest.
#' @param tolerance The maximum search distance for environmental hazards (optional).
#' @param units The units of the tolerance value (e.g., "m", "km", "ft", "yd", "fathom", "mi", "naut_mi", "au"),
#' if tolerance is specified.
#' @param weights An optional vector with the same length as to that applies a weight to each hazard.
#'
#'
#' @importFrom rlang .data
#'
#' @export
#' @examples
#' set.seed(123)
#' w <- floor(runif(nrow(npls), min=0, max=10))
#' #calculate proximity to all superfund sites
#' p <- get_proximity(from=ga, to=npls, weights = w)
#' plot(ga['Proximity'])
#' #calculate proximity to superfund sites within 10 miles of tract boundary
#' p10 <- get_proximity(from=ga, to=npls, tolerance = 10, units = 'mi', weights = w)
get_proximity<-function(from, to, tolerance=NULL, units='km', weights=NULL){

  #Verify length weights matches points (if provided)
  if(missing(weights)) {
    weights =  rep(1, nrow(to))
  }

  if(length(weights) != nrow(to))
    stop("`to` and `weights` must have the same length")

  #Verify `from` input is a spatial polygon
  if(!inherits(from, "sf") || !any(sf::st_geometry_type(from) %in% c("POLYGON", "MULTIPOLYGON"))){
    stop('Error: `from` must be a spatial polygon')
  }

  #Ensure polygon and points are sf objects with same CRS
  dflist <- sync_projection(from, to)
  from <- dflist[[1]]
  to <- dflist[[2]]

  #Calculate block area in square kilometers
  from <- from |>
    dplyr::mutate(st_areashape =
                    units::set_units(sf::st_area(from),"km^2")
                  )

  #Calculate block area equivalent radius
  from <- from |> dplyr::mutate(baeqRad = (.data$st_areashape/pi)^(1/2))

  #Calculate midpoint coordinates for each polygon
  suppressWarnings(
    from_centers<-from |> sf::st_centroid()
  )

  #Set maximum search distance in km
  tol_km <- units::set_units(
            if (is.null(tolerance)) 1e5 else as.numeric(to_km(tolerance, from = units)),
            'km')

  #Calculate distance (km) matrix
  distances <- as.matrix(sf::st_distance(from_centers, to))
  distances <- units::set_units(distances, 'km')

  # Prepare results list
  result_list <- vector("numeric", length = nrow(from))


  for (i in seq_len(nrow(from))) {
    dists <- distances[i, ]
    within_tol <- dists < tol_km

    if (!any(within_tol)) {
      # No points within tolerance — use minimum distance to all points
      min_idx <- which.min(dists)
      result_list[i] <- (1 / dists[min_idx]) * weights[min_idx]
    }

    else {
      # Calculate distances only to nearby points
      corrected <- ifelse(dists[within_tol] < from$baeqRad[i], dists[within_tol] * 0.9, dists[within_tol])
      wts <- weights[within_tol]
      result_list[i] <- sum((1 / corrected) * wts)
    }
  }

  return(result_list)
}
