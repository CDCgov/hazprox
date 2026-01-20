# Georgia Fire Locations

This dataset includes a subset of records from the National Interagency
Fire Occurrence 6th Edition 1992-2020, published by the U.S. Forest
Service. The Georgia Fire Locations dataset, **ga_fires.csv**, includes
fires occurring in the state of Georgia from 2016 through 2020.

## Usage

``` r
ga_fires
```

## Format

### `ga_fires`

A comma separated file with 16,195 rows and 11 columns:

- Id:

  Unique identifier of the incident

- Name:

  Descriptive name of fire

- Year:

  Year of the incident discovery

- Date:

  Date of incident discovery

- CauseType:

  Reason the fire occurred (Human, Natural, Missing, Unknown)

- Event:

  Event or circumstance that started or led to fire

- ControlDate:

  Date fire was declared controlled or contained

- Acres:

  Estimate of total area burned

- Owner:

  Agency responsible for responding at origin

- Lat:

  Latitude (NAD83) for point location of the fire (decimal degrees)

- Lon:

  Longitude (NAD83) for point location of the fire (decimal degrees)

## Source

<https://catalog.data.gov/dataset/national-interagency-fire-occurrence-sixth-edition-1992-2020-feature-layer>
\#nolint

<https://www.fs.usda.gov/rds/archive/catalog/RDS-2013-0009.6>

## Details

National Interagency Fire Occurrence records were acquired from the
reporting systems of federal, state, and local fire organizations. Data
are available for use under Creative Commons Attribution v4.0 License.

## References

Short, Karen C. 2022. Spatial wildfire occurrence data for the United
States, 1992-2020 (FPA_FOD_20221014). 6th Edition. Fort Collins, CO:
Forest Service Research Data Archive.
https://doi.org/10.2737/RDS-2013-0009.6

## See also

The script used to create the ga_fires dataset:
<https://github.com/cdcent/hazprox/blob/main/data-raw/ga-fires.R>
