
############################################################
# Script: Matriz de Correlación y Heatmap - concerts.csv
# Autor: Juan Nicolás Velásquez Rey
# Curso: Analítica de Datos para Administración y Finanzas
# Descripción: 
#   - Construye una matriz de correlación entre variables 
#     de gasto (spend) y ventas netas (net_sales).
#   - Genera un heatmap para visualizar las correlaciones.
############################################################
########################PRIMEMRA PARTE######################
# --- Cargar librerías ---
library(dplyr)
library(readr)
library(tibble)
library(ggplot2)
library(tidyr)
#install.packages("gt")   # si no lo tienes instalado
library(gt)    

# Cargar base
setwd("Lectures/03-medidas_central_y_visualización")
concerts <- read_csv("concerts.csv")

# Función para calcular moda
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

# Seleccionar columnas que cumplen el patrón
vars_interes <- concerts %>%
  select(matches("^impression_|^cost_|unemployment|cpi"), net_sales)

# Calcular estadísticas
resumen_estadistico <- vars_interes %>%
  summarise(
    Media = sapply(., mean, na.rm = TRUE),
    Mediana = sapply(., median, na.rm = TRUE),
    Moda = sapply(., get_mode),
    Varianza = sapply(., var, na.rm = TRUE),
    Desv_Estandar = sapply(., sd, na.rm = TRUE),
    Rango = sapply(., function(x) max(x, na.rm = TRUE) - min(x, na.rm = TRUE)),
    Coef_Variacion = sapply(., function(x) sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE))
  ) %>%
  t() %>%
  as.data.frame() %>%
  rownames_to_column(var = "Medida")

colnames(resumen_estadistico) <- c("Medida", colnames(vars_interes))

# Mostrar tabla bonita
resumen_estadistico %>%
  gt() %>%
  tab_header(
    title = "Resumen Estadístico - Variables de conciertos"
  ) %>%
  fmt_number(
    columns = where(is.numeric),  # Aplica a todas las columnas numéricas
    decimals = 2,                 # Número de decimales
    use_seps = TRUE               # Separadores de miles
  )

# Guardar tabla como imagen (requiere webshot2)
#install.packages("webshot2")  # si no lo tienes instalado
#webshot::install_phantomjs()   # solo la primera vez  
# Guardar como PNG
#gtsave(resumen_estadistico, "tabla.png")
# Guardar como PDF
#gtsave(resumen_estadistico, "tabla.pdf")

########################SEGUNDA PARTE##########################
# 1. Seleccionar columnas spend_ y net_sales

# 1. Filtrar solo variables cost_ y net_sales
vars_cor <- concerts %>%
  select(matches("^cost_"), net_sales) %>%
  na.omit()

# Matriz de correlación
matriz_cor <- cor(vars_cor, use = "complete.obs")

# Pasar a formato largo para heatmap
matriz_larga <- as.data.frame(matriz_cor) %>%
  tibble::rownames_to_column(var = "Var1") %>%
  pivot_longer(cols = -Var1, names_to = "Var2", values_to = "Correlacion")

# Heatmap
ggplot(matriz_larga, aes(x = Var1, y = Var2, fill = Correlacion)) +
  geom_tile(color = "white") +
  geom_text(aes(label = round(Correlacion, 2)), color = "black") +
  scale_fill_gradient2(low = "red", mid = "white", high = "blue", midpoint = 0) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(
    title = "Matriz de Correlación - Gasto y Ventas Netas",
    x = "",
    y = "",
    fill = "Correlación"
  )

# 2. Relación entre net_sales y unemployment
ggplot(concerts, aes(x = unemployment, y = net_sales)) +
  geom_point(color = "blue", alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  theme_minimal() +
  labs(
    title = "Relación entre Desempleo y Ventas Netas",
    x = "Tasa de Desempleo",
    y = "Ventas Netas"
  )

# 3. Justificación (texto para el análisis)
# Si la correlación entre 'unemployment' y 'net_sales' es alta (positiva o negativa),
# podría ser un predictor. Sin embargo, si la correlación es cercana a cero,
# no habría una relación lineal fuerte, y se requerirían otros factores o modelos
# más complejos para explicar las ventas netas.
# 3.1 Calcular la correlación entre net_sales y unemployment
correlacion_unemp_sales <- cor(concerts$net_sales, concerts$unemployment, use = "complete.obs")
correlacion_unemp_sales
