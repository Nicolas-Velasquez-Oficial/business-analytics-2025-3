##############################################################
# Taller de Business Analytics - Caso Tour Marketing (Opry) 
# Objetivo: Explorar la relación entre ventas y publicidad
# Autor: Juan Nicolás Velásquez Rey
##############################################################

# ============================================================
# 0. Preparación
# ============================================================
# - Instale y cargue las librerías necesarias para:
#   1. Leer datos (pista: readr)
#   2. Manipular datos (pista: dplyr)
#   3. Visualizaciones (pista: ggplot2)
#   4. Estadísticas descriptivas (pista: psych)

# ============================================================
# 1. Exploración inicial de los datos
# ============================================================
# - Importe la base de datos "Opry_data.csv"
# - Revise estructura y primeras filas
# - Obtenga un resumen estadístico de las variables clave:
#   Ventas, Gasto_Publicidad y las demas que desee incorporar
# - Haga un gráfico de dispersión entre Ventas y Gasto_Publicidad
# - Haga un gráfico temporal de Ventas y Gasto_Publicidad 
#   (pista: puede usar un segundo eje en ggplot2)

# ============================================================
# 2. Regresión naive (simple)
# ============================================================
# - Estime un modelo lineal simple:
#   Ventas ~ Gasto_Publicidad
#
# Preguntas:
# 1. ¿Cómo interpretan el intercepto?
# 2. ¿Cómo interpretan el coeficiente de Gasto_Publicidad?
# 3. ¿Es estadísticamente significativo (p-value y estrellas)?

# ============================================================
# 3. Regresión con dummy de estacionalidad
# ============================================================
#Usted como analista de datos sabe que en diciembre y enero las ventas son mas bajas debido a la estacionalidad del negocio.
# Por lo tanto, para mejorar el modelo: 
# - Cree una variable llamada Holliday_seasson 
#en donde sea 1 para las semanas mas bajas de ventas de diciembre y 
#enero en el año 2023, 2024 y 2025 e incluyalo al modelo:

#   Ventas ~ Gasto_Publicidad + Holliday_seasson
#
# Preguntas:
# 1. ¿Cómo cambia el coeficiente de Gasto_Publicidad respecto al modelo naive?
# 2. ¿Cómo interpretan el coeficiente de Holliday_seasson?

# ============================================================
# 4. Transformación logarítmica
# ============================================================
# - Cree una nueva variable dependiente:
#   Log_Ventas = log(Ventas)
# - Estime el modelo:
#   Log_Ventas ~ Gasto_Publicidad + Holliday_seasson
#
# Preguntas:
# 1. ¿Cómo se interpreta ahora el coeficiente de Gasto_Publicidad?
# 2. ¿Qué significa el intercepto en este modelo?

# ============================================================
# 5. Cree su propio modelo
# ============================================================
# - Agregue al menos UNA variable nueva ,
#   (ejemplo: Flights_to_Nashville, unemployment, cpi, etc...)
# También pueden mirar las ventas y ver si algun pico o valle muy pronunciado cuadra con un holliday que no este incluido en la base de datos y
# ustedes crearla y agregarla al modelo.
# - Use como dependiente Log_Ventas.
# - Estime el modelo y analice los resultados.
#
# Preguntas:
# 1. Interprete el coeficiente de Gasto_Publicidad.
# 2. Interprete el coeficiente de alguna dummy.
# 3. Interprete el coeficiente de la nueva variable que agregó.

# ============================================================
# 6. Exportación de resultados
# ============================================================
# - Exporte los resultados de su modelo a Word.
# - Pista: use librerías como broom, flextable y officer.
# - Puede crear una tabla con los coeficientes y R², 
#   y agregar un footnote con la interpretación de las estrellas.

# ============================================================
# 7. Reflexión final
# ============================================================
# - ¿Qué limitaciones tiene su modelo?
# - ¿Por qué creen que es un buen o mal modelo para predecir las ventas?
