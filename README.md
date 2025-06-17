<p align="center">
  <img src="069_GRASP_Logo_Color.png"/>
</p>

**Welcome to the Geospatial Research, Analysis, and Services Program (GRASP) Place & Health Code Hub!**

The mission of GRASP is to provide leadership and expertise in the application of the concepts, methods, and tools of geography and geospatial information science to public health research and practice. Visit the [GRASP homepage](https://www.atsdr.cdc.gov/place-health/index.html) to learn more about our work. 

---

# hazprox

**General disclaimer** This repository was created for use by CDC programs to collaborate 
on public health related projects in support of the [CDC mission](https://www.cdc.gov/about/cdc/index.html). 

GitHub is not hosted by the CDC, but is a third party website used by CDC and its partners 
to share information and collaborate on software. CDC use of GitHub does not imply an 
endorsement of any one particular service, product, or enterprise. 

## Overview

An R package for calculating cumulative, area-based proximity for simple features. 
The hazprox package can be used to support exploratory analysis of environmental hazards. 
This tool is based on the Superfund Proximity measurement described in the 
Environmental Protection Agency [EJScreen Tool Technical Documentation](https://www.epa.gov/system/files/documents/2024-07/ejscreen-tech-doc-version-2-3.pdf). 

**If you have questions about this project or need assistance, email ppk8@cdc.gov**

## Installation

Install the development version of hazprox from GitHub:

```r
library(remotes)
install_github('cdcgov/hazprox')
```

## Usage

`hazprox` calculates cumulative proximity  between simple feature (sf) geospatial objects 
(e.g., POINT, LINESTRING, POLYGON, MULTI*). Statistics are calculated for geographic areas,
represented by polygons, based on the inverse distance to other sf objects. `hazprox` comes
bundled with several example datasets including census tracts, fire locations, and Superfund
sites in the state of Georgia. Basic usage of the `get_proximity` function is shown below. 
More details on `hazprox` functions and datasets are available in the package documentation.  

```r
library(hazprox)
library(sf)

#import environmental hazard features
fires <- read.csv('inst/extdata/ga_fires.csv')
fires_sf <- sf::st_as_sf(fires, coords = c('Lon', 'Lat'), crs = 4269)

#calculate proximity to fires for all census tracts in Georgia
p <- get_proximity(from = ga, to = fires_sf)

```

## Contributing

We welcome and appreciate contributions. Please review our [contributing guidelines](CONTRIBUTING.md) for details on how to contribute to this project. 

By participating in this project, you agree to adhere the [Technology Transformation Service (TTS) code of conduct](https://handbook.tts.gsa.gov/about-us/code-of-conduct/) 
and to follow the [U.S. Department of Health and Human Services Rules of Behavior for Use of Information & IT Resources](https://security.cms.gov/policy-guidance/hhs-policy-rules-behavior-use-information-it-resources).

To report a bug or request a new feature, open a new issue.

## How to Cite
Rockhill S (2025). _hazprox: Population-Weighted Average Proximity to Hazards_. R
  package version 0.0.0.9000.
  
## See also 

* [Thanks and Acknowledgements](THANKS.md)
* [Disclaimer](DISCLAIMER.md)


## Public Domain Standard Notice
This repository constitutes a work of the United States Government and is not
subject to domestic copyright protection under 17 USC § 105. This repository is in
the public domain within the United States, and copyright and related rights in
the work worldwide are waived through the [CC0 1.0 Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
All contributions to this repository will be released under the CC0 dedication. By
submitting a pull request you are agreeing to comply with this waiver of
copyright interest.

## License Standard Notice
The repository utilizes code licensed under the terms of the Apache Software
License and therefore is licensed under ASL v2 or later.

This source code in this repository is free: you can redistribute it and/or modify it under
the terms of the Apache Software License version 2, or (at your option) any
later version.

This source code in this repository is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the Apache Software License for more details.

You should have received a copy of the Apache Software License along with this
program. If not, see http://www.apache.org/licenses/LICENSE-2.0.html

The source code forked from other open source projects will inherit its license.

## Privacy Standard Notice
This repository contains only non-sensitive, publicly available data and
information. All material and community participation is covered by the
[Disclaimer](DISCLAIMER.md).
For more information about CDC's privacy policy, please visit [http://www.cdc.gov/other/privacy.html](https://www.cdc.gov/other/privacy.html).

## Records Management Standard Notice
This repository is not a source of government records, but is a copy to increase
collaboration and collaborative potential. All government records will be
published through the [CDC web site](http://www.cdc.gov).
