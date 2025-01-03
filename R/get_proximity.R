library(sf)
library(dplyr)
library(glue)
#--------------------------------------------------------------------------------------
#Function to calculate proximity between polygons and points.
#--------------------------------------------------------------------------------------
#' @export
get_proximity<-function(from_poly, to_points, tolerance){

  #Ensure polygon and points are in same projection
  dflist <- sync_projection(from_poly, to_points)

  #Calculate block area in square kilometers
  from_poly <-dflist[[1]] %>%
    mutate(st_areashape = (ALAND+AWATER)/1000000)

  #Calculate block area equivalent radius
  from_poly <-from_poly %>%
    mutate(baeqRad = (st_areashape/pi)^(1/2))

  #Calculate midpoint coordinates for each polygon
  from_poly<-from_poly |> st_centroid()

  #Calculate distance (km) between each pair
  distances<-data.frame(
    matrix(
      st_distance(from_poly$geometry, dflist[[2]]$geometry)/1000,
      nrow=length(from_poly$geometry), ncol=length(dflist[[2]]$geometry)
    )
  )

  #Add block id and block area equivalent radius
  distances$GEOID<- from_poly$GEOID
  distances$baeqRad <- from_poly$baeqRad

  #Pivot longer and Calculate corrected distance
  distances <- distances %>%
    pivot_longer(cols=starts_with('X'), names_to = 'NPLRow', values_to = 'Distance') %>%
    mutate(CorrectedDistance = ifelse(Distance < baeqRad, Distance * 0.90, Distance))

  #Calculate sum of inverse distance
  distances<- distances %>%
    group_by(GEOID) %>%
    summarise(Block_Proximity_Score = ifelse(sum(Distance < tolerance)==0,
                                             1/min(Distance),
                                             sum(1/CorrectedDistance[Distance<tolerance])))


  return(distances)
}
