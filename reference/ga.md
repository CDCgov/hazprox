# Georgia Census Tracts

A spatial polygon dataset from the U.S. Census TIGER cartographic
boundary files (v2023). This dataset includes all 2020 census tracts in
the state of Georgia. Data are projected in NAD 1983 Georgia Statewide
Lambert.

## Usage

``` r
ga
```

## Format

### `gabgrps`

A spatial data frame with 2,791 rows and 5 columns:

- STATE:

  State abbreviation

- GEOID:

  11-digit unique identifier of the tract

- LSAD:

  Year

- POP:

  Estimate of total population

- geometry:

  geometry

## Source

<https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html>

<https://www.census.gov/programs-surveys/acs/data.html>

## Details

The dataset also includes a field containing total population counts
from 2023 American Community Survey (ACS) 5-Year Estimates.

## See also

The script used to create the ga dataset:
<https://github.com/cdcent/hazprox/blob/main/data-raw/>
