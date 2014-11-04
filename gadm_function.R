library(XML)
require(RCurl)
library(maps)

gadm <- function(country = "USA",
                 level = 2){
  
  # Get alpha-3 ISO codes from wikipedia, naming the resulting df x
  theurl <- "http://en.wikipedia.org/wiki/ISO_3166-1_alpha-3"
  tables <- readHTMLTable(theurl, stringsAsFactors = FALSE)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  
  x2 <- tables[[2]]; x2[nrow(x2)+1,] <- names(x2); names(x2) <- c("code", "country")
  x3 <- tables[[3]]; x3[nrow(x3)+1,] <- names(x3); names(x3) <- c("code", "country")
  x4 <- tables[[4]]; x4[nrow(x4)+1,] <- names(x4); names(x4) <- c("code", "country")
  
  x <- rbind(x2, x3, x4)
  x$country <- toupper(x$country)
  
  # which is the best ISO match with the given country?
  best_match <- adist(x = toupper(country),
                      y = x$country)
  best_match <- which.min(best_match)[1]
  
  country_code <- x$code[best_match]
  actual_country <- x$country[best_match]
    
  link <- paste0("http://biogeo.ucdavis.edu/data/gadm2/R/",
                 country_code,
                 "_adm",
                 level,
                 ".RData")
  

  if(url.exists(link)){
    new_link <- url(link)
  } else {
  stop("Try a different country or level")
  }
  
  actual_country <- gsub(" |,", "", tolower(actual_country))
  
  load(new_link,
         envir=environment()) # only loads into function environment
  x <- gadm
  assign(paste0(actual_country, level), x, envir =  .GlobalEnv)
  close(new_link)
  

    print(paste0("Your SpatialPolygonsDataFrame is named ",
                 actual_country, level))
}

# Try a few countries and levels, to see what you get
gadm("france")
gadm("haiti", 2)
gadm("shmaiti", 1)
gadm("congo", 1)
gadm("morococococo", 1)
gadm("Democratic Republic of yo mama", 1)
gadm("united states of america", 1)
gadm("CANTada", 1)
# Clearly, the name-matching isn't perfect
gadm("russia, the motherland")
gadm("argentina", 1)

# Add a few of these countries to world map
par(mar = c(0,0,0,0))
map("world")
plot(france2, col = "red", add = TRUE, border = FALSE)
plot(morocco1, col = "blue", add = TRUE, border = FALSE)
plot(unitedstates1, col = sample(rainbow(nrow(unitedstates1)),
                                 nrow(unitedstates1)),
     border = FALSE, add = TRUE)
plot(canada1, col = sample(rainbow(nrow(canada1)),
                                 nrow(canada1)),
     border = FALSE, add = TRUE)