# Adapted from code developed by Matthew A. Birk for the measurements package.
# Converts common units of length to kilometers

.conversions = data.frame(dim = character(0), unit = character(0), std = numeric(0))
.conversions = rbind(.conversions,

	data.frame(unit = 'angstrom', std = 1e10),
	data.frame(unit = 'nm', std = 1e9),
	data.frame(unit = 'um', std = 1e6),
	data.frame(unit = 'mm', std = 1e3),
	data.frame(unit = 'cm', std = 100),
	data.frame(unit = 'dm', std = 10),
	data.frame(unit = 'm', std = 1),
	data.frame(unit = 'meter', std = 1),
	data.frame(unit = 'metre', std = 1),
	data.frame(unit = 'km', std = 1e-3),
	data.frame(unit = 'inch', std = 100/2.54),
	data.frame(unit = 'in', std = 100/2.54),
	data.frame(unit = 'ft', std = 100/2.54/12),
	data.frame(unit = 'foot', std = 100/2.54/12),
	data.frame(unit = 'feet', std = 100/2.54/12),
	data.frame(unit = 'yd', std = 100/2.54/36),
	data.frame(unit = 'yard', std = 100/2.54/36),
	data.frame(unit = 'fathom', std = 100/2.54/72),
	data.frame(unit = 'mi', std = 100/2.54/12/5280),
	data.frame(unit = 'mile', std = 100/2.54/12/5280),
	data.frame(unit = 'naut_mi', std = 1/1852),
	data.frame(unit = 'au', std = 1/149597870700),
	data.frame(unit = 'AU', std = 1/149597870700),
	data.frame(unit = 'light_yr', std = 1/9460730472580800),
	data.frame(unit = 'light_year', std = 1/9460730472580800),
	data.frame(unit = 'parsec', std = 1/149597870700/(6.48e5/pi)),
	data.frame(unit = 'point', std = 100/2.54*72)
)

conv_unit = function(x, from){
	unit = std = NULL
	if(nrow(subset(.conversions,unit==from,dim))==0) stop('the \'from\' argument is not an acceptable unit.')
	value = x / subset(.conversions, unit == from, std, drop = TRUE)
	return(value * 0.001)
}
