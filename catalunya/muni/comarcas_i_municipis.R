library(rgdal)

setwd("/home/joebrew/Desktop/scq")

scq1 <- readOGR(".", "bt5mv20sh0f270119al1r040")
scq2 <- readOGR(".", "bt5mv20sh0f270119an1r040")
plot(scq2)

setwd("/home/joebrew/Desktop/muni")

comarca <- readOGR(".", "bm50mv33sh1fpc1r170")
muni <-readOGR(".", "bm50mv33sh1fpm1r170")

mycols <- colorRampPalette(c("white", "black"))(nrow(muni))
mycols <- sample(mycols, length(mycols))

plot(comarca, col = mycols, bg = "black")
plot(muni, add = TRUE, border = adjustcolor("black", alpha.f = 0.3),
     col = mycols)
plot(muni[which(muni$NOM_MUNI == "Santa Coloma de Queralt"),],
     col = "red",
     add = TRUE,
     border = FALSE)
