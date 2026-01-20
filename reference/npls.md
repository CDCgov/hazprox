# National Priority List/Superfund Sites

A spatial points data frame containing National Priority List (otherwise
known as Superfund) sites in the state of Georgia or within 5 km of the
state boundary. Data are projected in NAD 1983 Georgia Statewide
Lambert. Data were queried from the EPA Envirofacts API on August 26,
2025.

## Usage

``` r
npls
```

## Format

### `npls`

A data frame with 17 rows and 13 columns:

- NAME:

  Name of Superfund site

- EPA_ID:

  A unique 12-digit identification number assigned by the Superfund
  Enterprise Management System

- SITE_ID:

  Unique identifier for site for Superfunds with multiple sites

- STREET:

  Street address of Superfund location

- ADDR_C:

  Additional address information for Superfund location, if any

- CITY:

  City/town/village/municipality of Superfund location or nearest place
  name if site is not within a formal jurisdiction.

- COUNTY:

  County of Superfund location

- STATE:

  State of Superfund location

- ZIP:

  5-digit zip code of Superfund location

- DATE:

  Date that information was queried from the EPA Envirofacts API

- geometry:

  geometry

## Source

<https://enviro.epa.gov/>

## See also

The script used to create the npls dataset:
<https://github.com/cdcent/hazprox/blob/main/data-raw/npls.R>
