
# Clube do Livro R for Data Science -------------------------------------------------------------------------------------------------------------
# Encontro 8: Organização de dados (pacote tidyr) -----------------------------------------------------------------------------------------------
# Data: 06/08/2024 ------------------------------------------------------------------------------------------------------------------------------

# Conceitos --------------------------------------------------------------------------------------------------------------------------------

## Existem três regras que fazem com que um conjunto de dados seja
## seja considerado tidy:

## - Cada variável é uma coluna
## - Cada observação é uma linha
## - Cada valor é uma célula; cada célula um único valor

## Os pacotes dplyr, ggplot2 e os demais pacotes do tidyverse
## foram pensados para trabalhar com dados tidy.

# Instalar pacotes ------------------------------------------------------------------------------------------------------------------------------

##install.packages("tidyverse")
##install.packages("dados") # Conjunto de dados traduzidos

# Carregar pacotes ------------------------------------------------------------------------------------------------------------------------------

library(tidyverse)
library(dados)

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

## Exemplos de tabelas com diferentes organizações

## Tabelas com número de casos documentados de tuberculose.

tabela1 # Dados organizados
tabela2 # Duas variáveis em uma mesma coluna
tabela3 # Duas observações em uma mesma linha

# Alongando os dados -----------------------------------------------------------------------------------------------------------------------

## pivot_longer() 

billboard |> glimpse() 

billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "position"
  ) |>
  view()

billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "position",
    values_drop_na = TRUE,
  ) |>
  view()

billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week", # Fica em formato caracter
    values_to = "position",
    values_drop_na = TRUE,
  ) |>
  mutate(parse_number(week)) |> # Transforma em números apenas
  glimpse()

# Pivotagem --------------------------------------------------------------------------------------------------------------------------------

## ps - "pressão sanguínea"

df <- tribble(
  ~id,  ~ps1, ~ps2,
   "A",  100,  120,
   "B",  140,  115,
   "C",  120,  125
)

df |>
  pivot_longer(
    cols = starts_with("ps"),
    names_to = "medição",
    values_to = "valor"
  ) |>
  view()

view(who2)

who2 |> 
  pivot_longer(
    cols = !(country:year),
    names_to = c("diagnosis", "gender", "age"), # Nome de cada uma das 3 siglas separadas pelo underline
    names_sep = "_",
    values_to = "count"
  ) |>
  view()

view(household)

household |>
  pivot_longer(
    cols = !family,
    names_to = c(".value", "crianca"),
    names_sep = "_",
    values_drop_na = TRUE
  ) |>
  view()

# Alargando os dados -----------------------------------------------------------------------------------------------------------------------

## pivot_wider()

view(cms_patient_experience)

cms_patient_experience |> 
  distinct(measure_cd, measure_title) |>
  view()

cms_patient_experience |> 
  pivot_wider(
    names_from = measure_cd,
    values_from = prf_rate
  ) |>
  view()

cms_patient_experience |> 
  pivot_wider(
    id_cols = starts_with("org"),
    names_from = measure_cd, # Ignora a colina measue title que deixava com muitas linhas vazias
    values_from = prf_rate
  ) |>
  view()

# Exercícios -------------------------------------------------------------------------------------------------------------------------------

tabela1 |>
  mutate(taxa = casos/populacao * 10000) |>
  view()

view(tabela2)

tabela2 |>
  pivot_wider(
    names_from = tipo,
    values_from = contagem
  ) |> 
  glimpse() |>
  view()

## Calcular a taxa

tabela2 |>
  pivot_wider(
    names_from = tipo,
    values_from = contagem
  ) |> 
  mutate(taxa = casos/população * 10000) |>
  view()

view(tabela3)

tabela3 |>
  separate_wider_delim(
    cols = taxa, 
    delim = "/",
    names_sep = "") |>
  rename(casos = taxa1,
         população = taxa2) |>
  mutate(casos = parse_number(casos),
         população = parse_number(população)) |>
  view() |>
  glimpse()

tabela3 |>
  separate_wider_delim(
    cols = taxa, 
    delim = "/",
    names = c("casos", "população")) |>
  mutate(casos = parse_number(casos),
         população = parse_number(população)) |>
  view() |>
  glimpse()
