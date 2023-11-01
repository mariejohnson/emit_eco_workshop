closeAllConnections() # closes all file connections (like PDFs, PNGs, CSVs)
rm(list = ls()) # Clear variables
cat("\014") # Clear console

# Objective ---------------------------------------------------------------
# Split up land cover for canopy water content and LST processing
# Note - sedgwick is a lot smaller

# Libraries ---------------------------------------------------------------
setwd('~/emit_eco_workshop/land_cover')
library(raster)
# library(sf)
source('~/emit_eco_workshop/project_code/emit_eco_fxns.R')


# Import and process data -------------------------------------------------------------
# Site boundaries
danger_boundary <- st_read('~/emit_eco_workshop/project_data/dangermond/vectors/dangermond_boundary.shp')
sedg_boundary <- st_read('~/emit_eco_workshop/project_data/sedgwick/vectors/Sedgwick_Boundary.shp') # this needs to be reprojected
s_rpj <- st_transform(sedg_boundary, crs(danger_boundary))
st_write(s_rpj, '~/emit_eco_workshop/project_data/sedgwick/vectors/sedgwick_boundary_4326.shp')
sedg_boundary <- s_rpj

# NLCD
danger_nlcd <- raster('~/emit_eco_workshop/land_cover/nlcd/dangermond/dangermond_NLCD_2019_60m.tif')
sedg_nlcd <- raster('~/emit_eco_workshop/land_cover/nlcd/sedgwick/sedgwick_NLCD_2019_60m.tif')

# Mask to site bounds
d_nlcd <- mask(danger_nlcd, danger_boundary)
writeRaster(d_nlcd, '~/emit_eco_workshop/land_cover/nlcd/dangermond/dangermond_bounds_NLCD_2019_60m.tif')
s_nlcd <- mask(sedg_nlcd, sedg_boundary)
writeRaster(s_nlcd, '~/emit_eco_workshop/land_cover/nlcd/sedgwick/sedgwick_bounds_NLCD_2019_60m.tif')

# Rename/remove - first time only
danger_nlcd <- d_nlcd
rm(d_nlcd)
sedg_nlcd <- s_nlcd
rm(s_nlcd)


# Re-import ---------------------------------------------------------------
danger_nlcd <- raster('~/emit_eco_workshop/land_cover/nlcd/dangermond/dangermond_bounds_NLCD_2019_60m.tif')
sedg_nlcd <- raster('~/emit_eco_workshop/land_cover/nlcd/sedgwick/sedgwick_bounds_NLCD_2019_60m.tif')

# Split by land cover -----------------------------------------------------
# Dangermond land cover classes 
unique(danger_nlcd) # 11 21 22 23 31 42 43 52 71 81 90 95
prop.table(table(as.vector(danger_nlcd))) # 42 (EG - 23%), 43 (MF - 4%), 52 (SHR/SCB - 52%), 71 (grass/herb - 19%)
# Sedgwick
unique(sedg_nlcd)  # 21 22 42 43 52 71
prop.table(table(as.vector(sedg_nlcd))) # 42 (EG - 10%), 43 (MF - 3%), 52 (SHR/SCB - 71%), 71 (grass/herb - 15%)

# Since the highest frequency land covers match I will just use those for both
# Dangermond
d_evergreen <- clsMask1(danger_nlcd, 42) # For some reason when sf is loaded it doesn't like this function
writeRaster(d_evergreen, 'nlcd/dangermond/dangermond_bounds_NLCD_2019_60m_evergreen.tif')
d_mixed_forest <- clsMask1(danger_nlcd, 43) 
writeRaster(d_mixed_forest, 'nlcd/dangermond/dangermond_bounds_NLCD_2019_60m_mixed_forest.tif')
d_shrub_scrub <- clsMask1(danger_nlcd, 52) 
writeRaster(d_shrub_scrub, 'nlcd/dangermond/dangermond_bounds_NLCD_2019_60m_shrub_scrub.tif')
d_grass_herb <- clsMask1(danger_nlcd, 71) 
writeRaster(d_grass_herb, 'nlcd/dangermond/dangermond_bounds_NLCD_2019_60m_grass_herb.tif')

# Sedgwick
s_evergreen <- clsMask1(sedg_nlcd, 42) 
writeRaster(s_evergreen, '~/emit_eco_workshop/land_cover/nlcd/sedgwick/sedgwick_bounds_NLCD_2019_60m_evergreen.tif')
s_mixed_forest <- clsMask1(sedg_nlcd, 43) 
writeRaster(s_mixed_forest, '~/emit_eco_workshop/land_cover/nlcd/sedgwick/sedgwick_bounds_NLCD_2019_60m_mixed_forest.tif')
s_shrub_scrub <- clsMask1(sedg_nlcd, 52) 
writeRaster(s_shrub_scrub, '~/emit_eco_workshop/land_cover/nlcd/sedgwick/sedgwick_bounds_NLCD_2019_60m_shrub_scrub.tif')
s_grass_herb <- clsMask1(sedg_nlcd, 71) 
writeRaster(s_grass_herb, '~/emit_eco_workshop/land_cover/nlcd/sedgwick/sedgwick_bounds_NLCD_2019_60m_grass_herb.tif')

