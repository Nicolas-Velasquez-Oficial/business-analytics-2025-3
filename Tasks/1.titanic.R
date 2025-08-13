############################################################
# Script: Descriptives and Visulization- Titanic
# Autor: Juan Nicolás Velásquez Rey
# Curso: Analítica de Datos para Administración y Finanzas
# Descripción: 
#   - Construye graficos de barras, torta y pareto para la variable Pclass.
#   - Identifica la clase con más pasajeros.
############################################################
# Cargar librerías
library(dplyr)
library(readr)
library(tidyverse)

###setear directorio de trabajo
setwd("Lectures/02-tipos_de_datos_tidyverse")
titanic_path  <- "titanic.csv"

# Cargar librerías
library(ggplot2)
library(qcc)  # Para gráfico de Pareto

# 1. Cargar base
titanic <- read_csv(titanic_path)

# 2. Conteo de pasajeros por clase
conteo_pclass <- table(titanic$Pclass)
conteo_df <- as.data.frame(conteo_pclass)
colnames(conteo_df) <- c("Pclass", "Frecuencia")

# --- Gráfico de Barras ---
ggplot(conteo_df, aes(x = factor(Pclass), y = Frecuencia, fill = factor(Pclass))) +
  geom_bar(stat = "identity") +
  labs(title = "Cantidad de Pasajeros por Clase",
       x = "Clase",
       y = "Número de Pasajeros") +
  theme_minimal()

# --- Gráfico de Torta ---
ggplot(conteo_df, aes(x = "", y = Frecuencia, fill = factor(Pclass))) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Distribución de Pasajeros por Clase",
       fill = "Clase") +
  theme_void()

# Instalar si no lo tienes
install.packages("qcc")

# Cargar librería
library(qcc)


# Ordenar de mayor a menor frecuencia
conteo_df <- conteo_df[order(-conteo_df$Frecuencia), ]

# Gráfico de Pareto
pareto.chart(conteo_df$Frecuencia,
             names = conteo_df$Pclass,
             ylab = "Frecuencia",
             main = "Gráfico de Pareto - Pasajeros por Clase")

# 3. Clase con más pasajeros
# Encontrar la frecuencia máxima
max_frec <- max(conteo_df$Frecuencia)

# Filtrar todas las clases con esa frecuencia máxima
clases_mas_pasajeros <- conteo_df$Pclass[conteo_df$Frecuencia == max_frec]

# Mostrar resultado
print(paste("La(s) clase(s) con más pasajeros es/son:", paste(clases_mas_pasajeros, collapse = ", ")))


#La mejor foroma de mostrar estos resultados es con la grafica de pareto para mostrar relevancia de cada clase
