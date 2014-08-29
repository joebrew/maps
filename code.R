#####
# ATTACH PACKAGES
#####
library(maps)
library(maptools)

#####
# SET WORKING DIRECTORY TO MY MAP FOLDER
#####
setwd("C:/Users/BrewJR/Documents/maps")

#####
# WRITE PLOTTING FUNCTION
#####
MapFun <- function(country, 
                   level = 0,
                   keep = FALSE,
                   border="black",
                   #fill = TRUE,
                   col ="grey"){
  
  #LOAD
  load(paste0(tolower(country), level, ".RData"),
       if(keep){
         .GlobalEnv # loads into global environment
       }else{
         envir=environment() # only loads into function environment
       }
       )
  
  #PLOT
  plot(gadm, 
       col = col,
       border = border)
}

MapFun(country = "Spain", 
       level = 3,
       keep = FALSE,
       border="black",
       #fill = TRUE,
       col ="white")
