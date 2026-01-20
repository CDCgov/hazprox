# Confirms that spatial data are in same projected coordinate system. Transforms unprojected input into the projected coordinate reference system of the other input, if defined.

Confirms that spatial data are in same projected coordinate system.
Transforms unprojected input into the projected coordinate reference
system of the other input, if defined.

## Usage

``` r
sync_projection(df1, df2)
```

## Arguments

- df1:

  An object of class sf of sfc

- df2:

  An object of class sf of sfc

## Value

A list object containing both spatial data frames projected in the same
CRS.

## Examples

``` r
x = sf::st_polygon(list(rbind(c(33.9, -84.1),
                              c(33.9, -84.0),
                              c(34.0, -84.0),
                              c(34.0, -84.1),
                              c(33.9, -84.1))))
y = sf::st_point(c(34.1, -84))
x = sf::st_sfc(x, crs=4326)
y = sf::st_sfc(y, crs=4326)
#transform y into Albers Equal Area Conic projection
y = sf::st_transform(y, crs = 5070)
result <- sync_projection(x, y)
#> x does not have a projected CRS.
#> Projecting x into (+proj=aea +lat_0=23 +lon_0=-96 +lat_1=29.5 +lat_2=45.5 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs).
plot(result[[1]], ylim = c(6510000, 6550000), col = NA, border = 'red')
plot(result[[2]], add = TRUE, col =  'blue')


```
