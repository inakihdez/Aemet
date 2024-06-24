# call_url.R

install.packages("RSelenium")

library(RSelenium)

# Configura RSelenium para usar Chrome en GitHub Actions
rD <- rsDriver(browser = "chrome", port = 4445L, verbose = FALSE)
remDr <- rD$client

# Abre una URL
remDr$navigate("https://epdata.shinyapps.io/Aemet/?update=true")

# Realiza acciones adicionales si es necesario
# ...

# Cierra el navegador
remDr$close()

# Cierra el servidor Selenium
rD$server$stop()
