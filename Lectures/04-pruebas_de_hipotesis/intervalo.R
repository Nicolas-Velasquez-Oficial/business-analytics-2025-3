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


