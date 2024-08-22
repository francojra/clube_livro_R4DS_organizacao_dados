
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

## pivot_longer() e pivot_wider()

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
