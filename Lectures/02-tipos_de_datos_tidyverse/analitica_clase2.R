# ------------------------------------------------------
# Script: Análisis Exploratorio - Titanic Dataset
# Autor: Juan Nicolás Velásquez Rey
# Curso: Analítica de Datos
# Fecha: 30 de julio de 2025
# ------------------------------------------------------

# 1. Establecer el directorio de trabajo (ajusta esta ruta)
#setwd("C:/Users/TuNombre/Documents/ClaseAnaliticaDatos")
setwd("/Users/pdm/Library/CloudStorage/OneDrive-Universidaddelosandes/Catedra Javeriana/2025-3/lesson2")
getwd()  # Verifica que estás en el directorio correcto

# 2. Cargar librerías
install.packages("tidyverse")  # Descomenta si no tienes tidyverse

library(tidyverse)

# 3. Importar los datos
titanic <- read_csv("titanic.csv")

# 4. Explorar la estructura de los datos
glimpse(titanic)
head(titanic)

# 5. Confirmar si los datos están en formato 'tidy'
# Cada columna representa una variable y cada fila un pasajero. Este dataset cumple con ese formato.

# ------------------------------
# 6. Transformaciones básicas
# ------------------------------

# Crear una nueva variable: grupo de edad
titanic <- mutate(titanic, edad_grupo = if_else(Age < 18, "Menor", "Adulto"))

# Filtrar pasajeros que sobrevivieron
sobrevivientes <- filter(titanic, Survived == 1)

# Seleccionar columnas específicas
datos_basicos <- select(titanic, Name, Sex, Age)

# Filtrar y seleccionar en un solo paso
mujeres_sobrevivientes <- titanic |>
  filter(Sex == "female", Survived == 1) |>
  select(Name, Age, Pclass)

# Crear subconjunto con menores de edad
pasajeros_menores <- titanic |>
  filter(Age < 18) |>
  select(Name, Age, Sex)

# Mostrar algunas columnas
head(select(titanic, Name, Age, Sex))

# Filtrar por nombre específico
filter(titanic, Name == "Allen, Mr. William Henry")

# Eliminar filas con puerto 'S'
no_S <- filter(titanic, Embarked != "S")

# Filtrar pasajeros por puerto de embarque
filter(titanic, Embarked %in% c("C", "Q"))

# Filtrar pasajeros de primera o segunda clase
filter(titanic, Pclass %in% c(1, 2))


# ---------------------------------------
# 7. Lo anterior pero usando pipelines (%>% o |>)
# ---------------------------------------

titanic <- titanic |>
  mutate(edad_grupo = if_else(Age < 18, "Menor", "Adulto"))

sobrevivientes <- titanic |> filter(Survived == 1)

datos_basicos <- titanic |> select(Name, Sex, Age)

mujeres_sobrevivientes <- titanic |>
  filter(Sex == "female", Survived == 1) |>
  select(Name, Age, Pclass)

# Estadísticas descriptivas por sexo
resumen_edad <- titanic |>
  filter(!is.na(Age)) |>
  group_by(Sex) |>
  summarize(
    promedio = mean(Age),
    desviacion = sd(Age)
  )

# Acceder al promedio de edad de mujeres
resumen_edad |>
  filter(Sex == "female") |>
  pull(promedio)

# Función personalizada para resumen
resumen_edad <- function(x) {
  qs <- quantile(x, c(0.5, 0, 1), na.rm = TRUE)
  data.frame(mediana = qs[1], minimo = qs[2], maximo = qs[3])
}

# Aplicar la función personalizada a mujeres
titanic |>
  filter(Sex == "female") |>
  summarize(resumen_edad(Age))

# Estadísticas por sexo
reumen = titanic |>
  filter(!is.na(Age)) |>
  group_by(Sex) |>
  summarize(
    promedio_edad = mean(Age),
    mediana_edad = median(Age),
    total_pasajeros = n()
  )


# -------------------------------------
# 8. Gráfico de dispersión con ggplot2
# -------------------------------------
ggplot(titanic)


# Preparar datos
datos_filtrados <- titanic |>
  filter(!is.na(Age), !is.na(Fare), !is.na(Sex), !is.na(Pclass))

# Crear gráfico
ggplot(data = datos_filtrados, aes(x = Age, y = Fare)) +
  geom_point(aes(color = Sex, size = as.factor(Pclass)), alpha = 1.5) +
  labs(
    title = "Relación entre Edad y Tarifa en el Titanic",
    subtitle = "Colores por Sexo y Tamaño según Clase",
    x = "Edad del Pasajero",
    y = "Tarifa Pagada (Fare)",
    color = "Sexo",
    size = "Clase"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    plot.subtitle = element_text(size = 12),
    legend.position = "right"
  )


# -------------------------------------
# 9. Gráfico de pastel (pie chart)
# -------------------------------------

muertos <- titanic |> filter(Survived == 0)

muertos_por_sexo <- muertos |>
  count(Sex) |>
  mutate(porcentaje = n / sum(n) * 100)

ggplot(muertos_por_sexo, aes(x = "", y = porcentaje, fill = Sex)) +
  geom_col(width = 1, color = "white") +
  coord_polar("y") +
  labs(
    title = "Distribución de Muertes por Sexo en el Titanic",
    fill = "Sexo"
  ) +
  theme_void() +
  geom_text(
    aes(label = paste0(round(porcentaje, 1), "%")),
    position = position_stack(vjust = 0.5),
    color = "white", size = 5
  )


# -------------------------------------
# 10. Histograma de edades
# -------------------------------------

# Revisar valores faltantes en edad
sum(is.na(titanic$Age))

# Filtrar filas sin NA en Age
titanic_filtrado <- titanic |> filter(!is.na(Age))

# Crear histograma
ggplot(titanic_filtrado, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "white") +
  labs(
    title = "Distribución de Edades de los Pasajeros",
    x = "Edad",
    y = "Número de Pasajeros"
  ) +
  theme_minimal()
