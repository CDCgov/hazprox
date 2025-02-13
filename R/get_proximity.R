#' @title get_proximity
#'
#' @description
#' Function to calculate overall proximity to point-source
#' environmental hazards for areas. The function calculates
#' the sum of inverse distances between the geometric center
#' of the area and all hazards within a specified tolerance.
#' Proximity calculations for areas that do not have any hazards
#' within the specified tolerance only consider the single
#' nearest distance.

#' @param from_poly An spatial polygon layer with class sf or sfc. Proximity
#' statistics will be calculated for each polygon in this layer.
#' @param to_points A spatial points layer with class sf or sfc
#' representing the environmental hazard of interest.
#' @param tolerance The maximum search distance for environmental hazards (optional).
#'
#' @importFrom rlang .data
#'
#' @export
get_proximity<-function(from_poly, to_points, tolerance=NULL){

  #Ensure polygon and points are sf objects with same CRS
  dflist <- sync_projection(from_poly, to_points)

  #Calculate block area in square kilometers
  from_poly <-dflist[[1]] |>
    dplyr::mutate(st_areashape =
                    units::set_units(
                      sf::st_area(from_poly),
                    "km^2")
                  )

  #Calculate block area equivalent radius
  from_poly <-from_poly |>
    dplyr::mutate(baeqRad = (.data$st_areashape/pi)^(1/2))

  #Calculate midpoint coordinates for each polygon
  suppressWarnings(
    poly_centers<-from_poly |> sf::st_centroid()
  )

  #Calculate distance (km) between each pair
  distances<-data.frame(
    matrix(
      units::set_units(
        sf::st_distance(poly_centers, dflist[[2]]),
          'km'
      ),
      nrow=nrow(poly_centers),
      ncol=nrow(dflist[[2]])
    )
  )

  #Add block id and block area equivalent radius
  distances$ID<- as.numeric(row.names(from_poly))
  distances$baeqRad <- from_poly$baeqRad

  #Pivot longer and Calculate corrected distance
  distances <- distances |>
    tidyr::pivot_longer(cols=dplyr::starts_with('X'),
                        names_to = 'point',
                        values_to = 'Distance') |>
    dplyr::mutate(CorrectedDistance = ifelse(.data$Distance < as.numeric(.data$baeqRad),
                                             .data$Distance * 0.90,
                                             .data$Distance))

  #If tolerance is not provided, set to maximum distance
  if (missing(tolerance)) {
    tolerance <- max(distances$Distance, na.rm=T)
  }

  #Calculate sum of inverse distance
  distances<- distances |>
    dplyr::group_by(.data$ID) |>
    dplyr::summarise(Proximity = ifelse(sum(.data$Distance < tolerance)==0,
                                    1/min(.data$Distance),
                                    sum(1/.data$CorrectedDistance[.data$Distance<tolerance])))


  return(distances$Proximity)
}
