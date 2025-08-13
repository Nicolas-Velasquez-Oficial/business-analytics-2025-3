# -------------------------------
# Ejemplo de Merge con Formatos de Fecha Distintos
# Incluye un caso con texto como "12 de mayo de 2025"
# -------------------------------

library(dplyr)

# 1. Primera base (fecha en formato YYYY/MM/DD)
df1 <- data.frame(
  id_cliente = c(101, 102, 103),
  fecha_compra = c("2025/08/10", "2025/08/11", "2025/08/12"),
  monto = c(250, 300, 150)
)

# 2. Segunda base (fecha en formato texto tipo "12 de mayo de 2025")
df2 <- data.frame(
  id_cliente = c(101, 102, 104),
  fecha_compra = c("10 de agosto de 2025", "11 de agosto de 2025", "13 de agosto de 2025"),
  producto = c("Laptop", "Celular", "Tablet")
)

# -------------------------------
# IMPORTANTE: la columna en común será "id_cliente"
# y también la fecha una vez estandarizada.
# -------------------------------

# 3. Unificar formatos de fecha

# Para df1: fácil conversión usando as.Date
df1_clean <- df1 %>%
  mutate(fecha_compra_ddmmyyyy = format(as.Date(fecha_compra, format = "%Y/%m/%d"), "%d-%m-%Y")) %>%
  select(id_cliente, fecha_compra_ddmmyyyy, monto)

# Para df2: primero debemos mapear meses en español a números
meses <- c("enero"=1, "febrero"=2, "marzo"=3, "abril"=4,
           "mayo"=5, "junio"=6, "julio"=7, "agosto"=8,
           "septiembre"=9, "octubre"=10, "noviembre"=11, "diciembre"=12)

df2_clean <- df2 %>%
  rowwise() %>%
  mutate(
    dia = as.numeric(strsplit(fecha_compra, " ")[[1]][1]),
    mes_texto = strsplit(fecha_compra, " ")[[1]][3],
    anio = as.numeric(strsplit(fecha_compra, " ")[[1]][5]),
    mes = meses[mes_texto],
    fecha_compra_ddmmyyyy = sprintf("%02d-%02d-%04d", dia, mes, anio)
  ) %>%
  ungroup() %>%
  select(id_cliente, fecha_compra_ddmmyyyy, producto)

# -------------------------------
# 4. Merge final usando la clave y fecha unificada
# -------------------------------
base_unificada <- df1_clean %>%
  inner_join(df2_clean, by = c("id_cliente", "fecha_compra_ddmmyyyy"))

# -------------------------------
# 5. Resultado listo para análisis
# -------------------------------
print(base_unificada)
