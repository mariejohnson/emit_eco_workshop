closeAllConnections() # closes all file connections (like PDFs, PNGs, CSVs)
rm(list = ls()) # Clear variables
cat("\014") # Clear console

# Objective ---------------------------------------------------------------
# quick LST and CWC comparison

# Libraries ---------------------------------------------------------------
setwd('~/emit_eco_workshop/')
library(raster)
library(ggplot2)
# library(sf)
source('~/emit_eco_workshop/project_code/emit_eco_fxns.R')


# Import data -------------------------------------------------------------
cwc_april <- raster('/Users/mj129827/emit_eco_workshop/cwc/EMIT_L2A_RFL_001_20230401T203751_2309114_002_dangermond_cwc.tiff')
plot(cwc_april)
lst_april <- raster('/Users/mj129827/emit_eco_workshop/lst/ECOv002_L2T_LSTE_26860_001_10SGD_20230401T203733_0710_01_LST_dangermond.tiff')
plot(lst_april)

april <- stack(cwc_april, lst_april)

cwc_sept <- raster('/Users/mj129827/emit_eco_workshop/cwc/EMIT_L2A_RFL_001_20230923T232101_2326615_002_dangermond_cwc.tiff')
lst_sept <- raster('/Users/mj129827/emit_eco_workshop/lst/ECOv002_L2T_LSTE_29576_005_10SGD_20230923T232104_0710_01_LST_dangermond.tiff')

sept <- stack(cwc_sept, lst_sept)
# Data frames  -------------------------------------------------------
# df_cwc_april <- as.data.frame(cwc_april, xy=F, na.rm=T)
# df_lst_april <- as.data.frame(lst_april, xy=F, na.rm=T)

df_april <- as.data.frame(april, xy=F, na.rm=T)
names(df_april) <- c('canopy_water_content', 'land_surface_temp')
df_sept <- as.data.frame(sept, xy=F, na.rm=T)
names(df_sept) <- c('canopy_water_content', 'land_surface_temp')

# plot(df_april$canopy_water_content, df_april$land_surface_temp)
# 
# cor(df_april$canopy_water_content, df_april$land_surface_temp, method = "pearson", use = "complete.obs")
# 
# 
# lm_april <- lm(canopy_water_content ~ land_surface_temp, data = df_april )


cbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# CWC --------------------------------------------------------------
ggplot(data=df_april, aes(x=canopy_water_content))+
  geom_histogram()+
  ggtitle("Dangermond")+
  labs(x="CWC"~(g/cm^2))+
  # scale_fill_manual(values = cbPalette, name = "Year")+
  theme_light()+
  # scale_y_continuous(breaks = seq(0, 13, by= 2))+
  theme(axis.title = element_text(size = 26),
        axis.text = element_text(size=22),
        plot.title = element_text(color = "black", size = 25, hjust = 0.5),
        legend.text = element_text(size = 24),
        legend.title = element_text(size = 24))

# LST ---------------------------------------------------------------------
ggplot(data=df_april, aes(x=land_surface_temp))+
  geom_histogram()+
  ggtitle("Dangermond")+
  labs(x="Land Surface Temperature K")+
  # scale_fill_manual(values = cbPalette, name = "Year")+
  theme_light()+
  # scale_y_continuous(breaks = seq(0, 13, by= 2))+
  theme(axis.title = element_text(size = 26),
        axis.text = element_text(size=22),
        plot.title = element_text(color = "black", size = 25, hjust = 0.5),
        legend.text = element_text(size = 24),
        legend.title = element_text(size = 24))


# Scatterplot -------------------------------------------------------------
ggplot(data=df_april, aes(x=land_surface_temp, y=canopy_water_content))+
  geom_point()+
  geom_smooth(color='blue', method='lm')+
  ggtitle("Dangermond")+
  labs(x="Land Surface Temperature K", y= 'Canopy Water Content')+
  # scale_fill_manual(values = cbPalette, name = "Year")+
  theme_light()+
  # scale_y_continuous(breaks = seq(0, 13, by= 2))+
  theme(axis.title = element_text(size = 26),
        axis.text = element_text(size=22),
        plot.title = element_text(color = "black", size = 25, hjust = 0.5),
        legend.text = element_text(size = 24),
        legend.title = element_text(size = 24))

# September ---------------------------------------------------------------
# CWC --------------------------------------------------------------
ggplot(data=df_april, aes(x=canopy_water_content))+
  geom_histogram()+
  ggtitle("Dangermond")+
  labs(x="CWC"~(g/cm^2))+
  # scale_fill_manual(values = cbPalette, name = "Year")+
  theme_light()+
  # scale_y_continuous(breaks = seq(0, 13, by= 2))+
  theme(axis.title = element_text(size = 26),
        axis.text = element_text(size=22),
        plot.title = element_text(color = "black", size = 25, hjust = 0.5),
        legend.text = element_text(size = 24),
        legend.title = element_text(size = 24))

# LST ---------------------------------------------------------------------
ggplot(data=df_april, aes(x=land_surface_temp))+
  geom_histogram()+
  ggtitle("Dangermond")+
  labs(x="Land Surface Temperature K")+
  # scale_fill_manual(values = cbPalette, name = "Year")+
  theme_light()+
  # scale_y_continuous(breaks = seq(0, 13, by= 2))+
  theme(axis.title = element_text(size = 26),
        axis.text = element_text(size=22),
        plot.title = element_text(color = "black", size = 25, hjust = 0.5),
        legend.text = element_text(size = 24),
        legend.title = element_text(size = 24))


# Scatterplot -------------------------------------------------------------
ggplot(data=df_april, aes(x=land_surface_temp, y=canopy_water_content))+
  geom_point()+
  geom_smooth(color='blue', method='lm')+
  ggtitle("Dangermond")+
  labs(x="Land Surface Temperature K", y= 'Canopy Water Content')+
  # scale_fill_manual(values = cbPalette, name = "Year")+
  theme_light()+
  # scale_y_continuous(breaks = seq(0, 13, by= 2))+
  theme(axis.title = element_text(size = 26),
        axis.text = element_text(size=22),
        plot.title = element_text(color = "black", size = 25, hjust = 0.5),
        legend.text = element_text(size = 24),
        legend.title = element_text(size = 24))



