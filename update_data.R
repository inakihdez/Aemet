# Instalar paquetes necesarios si no están instalados
required_packages <- c("httr", "dplyr", "tidyr", "sf", "shiny", "remotes")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]

if(length(new_packages)) {
  install.packages(new_packages)
}

# Instalar paquetes desde GitHub si no están instalados
if(!"climaemet" %in% installed.packages()[,"Package"]) {
  remotes::install.packages("climaemet")
}
if(!"datawRappr" %in% installed.packages()[,"Package"]) {
  remotes::install_github("munichrocker/DatawRappr")
}

# Cargar paquetes
library(climaemet)
library(DatawRappr)
library(dplyr)
library(tidyr)
library(sf)

# Autenticación de APIs
aemet_api_key("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJpbmFraWhlcm5hbmRlekBldXJvcGFwcmVzcy5lcyIsImp0aSI6IjZhZWM1ZmJjLTMxNDYtNDI3My1iZGQwLWI5NzAwZDg3OTQwMyIsImlzcyI6IkFFTUVUIiwiaWF0IjoxNjg4OTg3NTYyLCJ1c2VySWQiOiI2YWVjNWZiYy0zMTQ2LTQyNzMtYmRkMC1iOTcwMGQ4Nzk0MDMiLCJyb2xlIjoiIn0.9688ngtL8YVv9n9i0zP0R1jkl5jpXP2IA7p-EXw1SOA")
datawrapper_auth(api_key = "HifTuXZg2FBZbazwKaAz8bOG7LrZQunf8RJEIrQgbalErCiwlo0f9KBwWbTKvBoN")

# Obtener datos y procesarlos
all_last <- aemet_last_obs(return_sf = TRUE)
Maximas <- all_last %>% group_by(ubi) %>% filter(tamax == max(tamax))
Maximas <- Maximas[,c(2,9, 11,13,38)]

Maximas$Limpio <- substr(Maximas$geometry, 2,30)
Maximas$Limpio <- gsub("\\(", "", Maximas$Limpio)
Maximas$Limpio <- gsub("\\)", "", Maximas$Limpio)
Maximas <- separate(Maximas, Limpio, into=c("Lat", "Long"), sep=",")

# Subir y publicar datos en Datawrapper
dw_data_to_chart(Maximas, "e9AET", parse_dates = TRUE)
dw_publish_chart("e9AET")
