# Objective ---------------------------------------------------------------
# Store all functions here related to ecostress and emit code

# Template rasters --------------------------------------------------------
tRes_70m <- c(0.0006288207, 0.0006288207) # 70m resolution  0.0006288207
tRes_60m <- c(0.0005389892, 0.0005389892) # 60m resolution
prj4326 <- '+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0'
# Extent taken from site shapefiles
# Dangermond
d_ext <- extent(-120.4993, -120.3577, 34.4423, 34.57418)
d_rast <- raster(crs=prj4326, ext=d_ext, resolution = tRes_60m)

# Sedgwick
s_ext <- extent(-120.0717, -120.0118, 34.67874, 34.74399)
s_rast <- raster(crs=prj4326, ext=s_ext, resolution = tRes_60m)


# Functions ---------------------------------------------------------------
clsMask1 <- function(inRast, theVal){ # inRast: input raster to create mask from. theVal: the value you want to keep ex: vals != 52, the value that does not equal the one you want to keep
  require(raster)
  newRast <- raster()
  vals <- getValues(inRast)
  ind <- c(which(vals != theVal))
  newRast = inRast
  newRast[ind] = NA
  newRast
}
# Example:
# afg18 <- clsMask1(dc2018, 1) dc2018: dominant cover in 2018, 1 is the value to keep (which is annual forbs and grasses)

