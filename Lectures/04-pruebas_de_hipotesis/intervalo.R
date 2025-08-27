# Primero incluyamos unas variables
p <- 0.45
N <- 30
# Ahora calculemosx el intervalo
# la función sample() que se utiliza para generar una muestra aleatoria.
x <- sample(c(0, 1), size = N, replace = TRUE, prob = c(1-p, p))
x_hat <- mean(x)
se_hat <- sqrt(x_hat * (1 - x_hat)/ N)
# Ahora calculemos el intervalo de confianza
# El intervalo de confianza al 95% para la proporción poblacional
c(x_hat - 1.96 * se_hat, x_hat + 1.96 * se_hat)
# Ahora calculemos el intervalo de confianza
# El intervalo de confianza al 90% para la proporción poblacional
c(x_hat - 1.645 * se_hat, x_hat + 1.645 * se_hat)


# Cargar la biblioteca necesaria
library(tibble) 
#Es de tidyverse Crear el dataframe para usar ahora
df <- tibble(Local = c(16.8, 11.7, 15.6, 16.7, 17.5, 18.1, 14.1, 21.8, 13.9, 20.8),
Cadena = c(22, 15.2, 18.7, 15.6, 20.8, 19.5, 17, 19.5, 16.5, 24))
# Mostrar el marco de datos
print(df)
# Realizar la prueba t para muestras relacionadas
resultado <- t.test(df$Local, df$Cadena, paired = TRUE, alternative = "less")
# Mostrar el resultado de la prueba
print(resultado)
