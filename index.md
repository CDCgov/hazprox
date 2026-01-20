# hazprox

***General disclaimer:*** *This repository was created for use by CDC
programs to collaborate on public health related projects in support of
the [CDC mission](https://www.cdc.gov/about/cdc/index.html). GitHub is
not hosted by CDC, but is a third-party website used by CDC and its
partners to share information and collaborate on software. CDC use of
GitHub does not imply endorsement of any service, product, or
enterprise.*

------------------------------------------------------------------------

## Overview

hazprox includes tools for calculating cumulative, area-based proximity
for simple feature objects. The hazprox package can be used to quantify
how close a geographic area is to other features of interest and is
intended to support exploratory analysis of environmental hazards. This
tool is based on the Superfund Proximity measurement described in the
Environmental Protection Agency [EJScreen Tool Technical
Documentation](https://www.epa.gov/system/files/documents/2024-07/ejscreen-tech-doc-version-2-3.pdf).

## Installation

Install the development version of hazprox from GitHub:

``` r
library(remotes)
install_github('cdcgov/hazprox')
```

To install and view available vignettes, specify,
`build_vignettes = TRUE` in your install statement:

``` r
install_github('cdcgov/hazprox', build_vignettes = TRUE)
browseVignettes(package = 'hazprox')
```

## Usage

hazprox allows users to calculate cumulative proximity between simple
feature (sf) geospatial objects (e.g., POINT, LINESTRING, POLYGON,
MULTI\*). Statistics are calculated for geographic areas, represented by
polygons, based on the inverse distance to other sf objects. The hazprox
package comes bundled with several example datasets, including census
tracts, fire locations, and Superfund sites in the state of Georgia.
Basic usage of the
[`get_proximity()`](https://cdcgov.github.io/hazprox/reference/get_proximity.md)
function is shown below. More details on `hazprox` functions and
datasets are available in the package documentation.

``` r
library(hazprox)
library(sf)

#import environmental hazard features
fires <- read.csv('inst/extdata/ga_fires.csv')
fires_sf <- sf::st_as_sf(fires, coords = c('Lon', 'Lat'), crs = 4269)

#calculate proximity to fires for all census tracts in Georgia
p <- get_proximity(from = ga, to = fires_sf)
```

## Recommended Citation

Rockhill S (2025). *hazprox: Population-Weighted Average Proximity to
Hazards*. R package version 0.0.0.9000.

## Getting Help

If you have questions about this project or need assistance, email
<srockhill@cdc.gov>.

## See Also

- [Thanks and
  Acknowledgements](https://cdcgov.github.io/hazprox/THANKS.md)
- [Disclaimer](https://cdcgov.github.io/hazprox/DISCLAIMER.md)

## Public Domain Standard Notice

This repository constitutes a work of the United States government and
is not subject to domestic copyright protection under 17 USC § 105. This
repository is in the public domain within the United States, and
copyright and related rights in the work worldwide are waived through
the [CC0 1.0 Universal public domain
dedication](https://creativecommons.org/publicdomain/zero/1.0/). All
contributions to this repository will be released under the CC0
dedication. By submitting a pull request, you are agreeing to comply
with this waiver of copyright interest.

## License Standard Notice

The repository utilizes code licensed under the terms of the Apache
Software License and therefore is licensed under ASL v2 or later.

The source code in this repository is free: you can redistribute it
and/or modify it under the terms of the Apache Software License version
2, or (at your option) any later version.

This source code in this repository is distributed in the hope that it
will be useful, but WITHOUT ANY WARRANTY; without even implied warranty
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the Apache
Software License for more details.

You should have received a copy of the Apache Software License along
with this program. If not, see
[http://www.apache.org/licenses/LICENSE-2.0.html](http://www.apache.org/licenses/LICENSE-2.0.md).

The source code forked from other open-source projects will inherit its
license.

## Privacy Standard Notice

This repository contains only non-sensitive, publicly available data and
information. All material and community participation is covered by the
[disclaimer](https://cdcgov.github.io/hazprox/DISCLAIMER.md). For more
information about CDC’s privacy policy, please visit
[http://www.cdc.gov/other/privacy.html](https://www.cdc.gov/other/privacy.html).

## Records Management Standard Notice

This repository is not a source of government records, but is a copy to
increase collaboration and collaborative potential. All government
records will be published through the [CDC web
site](http://www.cdc.gov).
