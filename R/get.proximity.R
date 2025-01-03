library(sf)
#--------------------------------------------------------------------------------------
#Function to calculate proximity between polygons and points.
#--------------------------------------------------------------------------------------
#' @export
calc_proximity_scores<-function(from_blocks, to_points, tolerance){

  #Calculate midpoint coordinates for each block
  from_blocks<-from_blocks |> st_centroid()

  #Calculate block area in square kilometers
  from_blocks <-from_blocks %>%
    mutate(st_areashape = (ALAND+AWATER)/1000000)

  #Calculate block area equivalent radius
  from_blocks <-from_blocks %>%
    mutate(baeqRad = (st_areashape/pi)^(1/2))

  #Calculate distance (km) between each pair
  distances<-data.frame(
    matrix(
      st_distance(from_blocks$geometry, to_points$geometry)/1000,
      nrow=length(from_blocks$geometry), ncol=length(to_points$geometry)
    )
  )

  #Add block id and block area equivalent radius
  distances$GEOID<- from_blocks$GEOID
  distances$baeqRad <- from_blocks$baeqRad

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

  #Merge inverse distances back to block data
  #dataset<-merge(dataset, distances, by='GEOID', all.x=T)
  return(distances)
}
