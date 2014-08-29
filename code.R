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
                   col ="grey",
                   pdf = FALSE,
                   xlim = NULL,
                   ylim = NULL){
  
  par(mar=c(0,0,0,0))
  par(oma=c(0,0,0,0))
  
  
  #LOAD
  load(paste0(tolower(country), level, ".RData"),
       if(keep){
         .GlobalEnv # loads into global environment
       }else{
         envir=environment() # only loads into function environment
       }
       )
  
  # PDF
  if (pdf){
    pdf(paste0(country, ".pdf"),
        height= 3,
        width = 3)
    
    if (!is.null(xlim) & !(is.null(ylim))){
      plot(gadm, 
           lwd = 0.2,
           col = col,
           border = border,
           xlim=xlim,
           ylim=ylim)
    }else{
      plot(gadm, 
           lwd = 0.2,
           col = col,
           border = border)
    }
    dev.off()
  }
  #PLOT
  if (!is.null(xlim) & !(is.null(ylim))){
    plot(gadm, lwd = 0.2,
         col = col,
         border = border,
         xlim=xlim,
         ylim=ylim)
  }else{
    plot(gadm, lwd = 0.2,
         col = col,
         border = border)
  }

}

par(mar=c(0,0,0,0))
par(oma=c(0,0,0,0))

MapFun(country = "spain", 
       level = 2,
       keep = FALSE,
       border="black",
       #fill = TRUE,
       col = "white",
       pdf = TRUE)
