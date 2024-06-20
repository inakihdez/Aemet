library(httr)

# URL de tu aplicación Shiny con el parámetro de actualización
url <- "https://epdata.shinyapps.io/Aemet/?update=true"

# Enviar la solicitud GET
response <- GET(url, config(followlocation = TRUE), verbose())

# Verificar el estado de la respuesta
if (status_code(response) == 200) {
  print("Solicitud enviada correctamente.")
} else {
  print(paste("Error:", status_code(response)))
}

# Mostrar el contenido de la respuesta
print(content(response, "text"))
