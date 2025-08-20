##############################################################
# Parcial – Corte I
# Business Analytics – Sección 3
# Nombre: _______________________
# Correo: _______________________
# Fecha:  2025-08-20
##############################################################

# Instrucciones:
# - Solo se permite el uso de sus notebooks y del código en R trabajado durante el curso.
# - Tiempo disponible: 90 minutos.
# - Entrega: enviar este archivo (apellido_nombre.R) al correo:
#   velasquez_juan@javeriana.edu.co
# - Incluya en este archivo:
#   (1) Las respuestas de la parte teórica en la tabla de respuestas.
#   (2) El código utilizado para cálculos, gráficos y justificaciones en la Parte 2.
# - Documente claramente su código.

##############################################################
# TABLA DE RESPUESTAS – PARTE 1
# (Complete con la letra de su respuesta en cada número)
##############################################################

respuestas_parte1 <- data.frame(
  Pregunta = 1:5,
  Respuesta = c("", "", "", "", "")  # <-- Complete aquí con a, b, c, d o e
)

print(respuestas_parte1)

##############################################################
# PARTE 2 (3.0 puntos) – Análisis con base Petronio_2025.csv
##############################################################
# Contexto:
# La base Petronio_2025.csv contiene las ventas por clientet e incluye:
# - Producto (ej: Viche, Curao, Tomaseca, Empanada de Piangua,...)
# - Tipo (ej: Comida, Bebidas, Artesanías)
# - Ventas (en pesos COP)
# - Unidades vendidas
# - Fecha (del 13 al 18 de agosto)

# A partir de esta información, desarrolle los siguientes puntos:

# ------------------------------------------------------------
# 1. (0.666 puntos)
# Realice un análisis descriptivo de las variables "Ventas" por Producto,
# mostrando la media, mediana, desviación estándar y máximo/mínimo
# A.por Producto y B.por Día del evento.
# También, guarde los resultados en archivos CSV separados (desc_producto.csv y desc_dia.csv).
# Para el análisis descriptivo, se puede usar la función aggregate
# o dplyr para agrupar y resumir los datos.
# Ejemplo de uso de aggregate:
# aggregate(Petronio$Ventas, by = list(Petronio$Producto), FUN = mean)
# aggregate(Petronio$Unidades, by = list(Petronio$Día), FUN = sum)


# ------------------------------------------------------------
# 2. (0.666 puntos)
# Construya una tabla que muestre el total de Ventas y Unidades
# para cada Tipo de producto (Artesania, Bebida o Comida).
# A partir de la tabla, identifique el Tipo de producto más vendido.
# Su Valor Total de Ventas y Unidades Vendidas durante los 6 dias.


# ------------------------------------------------------------
# 3. (0.666 puntos)
# Genere un gráfico de barras que muestre cuál Producto tuvo mayores ventas
# totales durante el festival. 
# IMPORTANTE: 
# - El eje X debe llamarse "Producto"
# - El eje Y debe llamarse "Ventas Totales (COP)"
# - El título del gráfico debe ser "Ventas totales por producto durante el Petronio 2025"
# - Puede usar colores diferentes para cada tipo de producto si lo desea
# - El gráfico debe mostrar las ventas totales (suma) de cada producto en Millones de COP

# Ejemplo (ajustar según su base):
library(ggplot2)

ggplot(X, aes(x = X, y = Y, fill = Z)) +
  geom_bar(stat = "summary", fun = "sum") +
  labs(
    title = "titulo",
    x = "Eje X",
    y = "Eje Y"
  ) +
  theme_minimal()

# ------------------------------------------------------------
# 4. (1.00 puntos)
# Reflexión (responda en comentario dentro del script):
# Durante el 17 y 18 de agosto se realizaron los conciertos con grupos invitados más reconocidos.
# A partir de los resultados obtenidos sobre las ventas por día en el Punto 1 y poro Producto en el Punto 3.
# ¿qué relación, si alguna, observa entre estos hechos y los patrones de ventas del festival?
# Explique su conclusión considerando el impacto económico y cultural de los productos.
