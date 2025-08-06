# Cargar librerías
library(dplyr)
library(readr)
library(tidyverse)

###setear directorio de trabajo
setwd("/Users/pdm/Library/CloudStorage/OneDrive-Universidaddelosandes/Catedra Javeriana/business-analytics-2025-3/Lectures/03-medidas_central_y_visualización/")

# Leer el archivo CSV
concerts <- read_csv("concerts.csv")

# Ver las primeras filas para identificar las columnas
head(concerts)

# Calcular media y desviación estándar de todas las columnas numéricas
summary_stats <- concerts %>%
  select(where(is.numeric)) %>%  # Selecciona solo columnas numéricas
  summarise_all(list(
    media = ~mean(., na.rm = TRUE),
    desviacion = ~sd(., na.rm = TRUE)
  ))

# Mostrar resultados
print(summary_stats)


#install.packages("ggcorrplot")   # Solo si no lo tienes
#install.packages("readr")
#install.packages("dplyr")

library(ggcorrplot)
library(readr)
library(dplyr)

concerts_numeric <- concerts %>%
  select(where(is.numeric))  # Selecciona solo columnas numéricas

# Calcular matriz de correlaciones
cor_matrix <- cor(concerts_numeric, use = "complete.obs")

# Graficar matriz de correlaciones
ggcorrplot(cor_matrix, 
           method = "circle", 
           type = "lower", 
           lab = TRUE, 
           lab_size = 3, 
           colors = c("blue", "white", "red"), 
           title = "Matriz de Correlación")


# Calcular matriz de covarianza
cov_matrix <- cov(concerts_numeric, use = "complete.obs")

# Visualizar como heatmap base (menos bonito)
heatmap(cov_matrix, 
        main = "Matriz de Covarianza", 
        col = colorRampPalette(c("blue", "white", "red"))(100), 
        scale = "none")
