# Arquivo: 02-lista.R
# Autor(a): Eunice Oliveira
# Data: 07/04/2026
# Objetivo:
# 1. Resolver os exercícios da lista 2


# Configurações globais ---------------------------------------------------

# Configura o número de dígitos a serem exibidos
options(digits = 5, scipen = 999)

# carrega os pacotes necessários
library(here) # para usar caminhos relativos
library(tidyverse) # carrega o dplyr, readr, ggplot2, etc.
library(janitor) # para limpar os nomes das colunas

# Exercicio 1 -------------------------------------------------------------


## a)


## b)# define o caminho relativo do arquivo de dados
dados_marketing <- read_csv("caminho_csv, show_col_types = FALSE")



## c)# exibe uma visão compacta do objeto
glimpse(dados_marketing)





# Exercicio 2 -------------------------------------------------------------

## a)# Cada linha do arquivo representa uma semana de observação. Assim, as 
# observações não correspondem a vendas individuais, mas a registros semanais
# com informações sobre investimentos em diferentes canais de marketing, 
# ocorrencia de promoção, atividade concorrente e receita de vendas.


## b)# variaveis( são as colunas) 9 e observação ( são linhas) 156


# Exercicio 3 -------------------------------------------------------------

## a)# padronize os nomes das colunas e crie um novo objeto chamado dados_marketing_limpos

dados_marketing_limpos <- dados_marketing |>
  clean_names()



## b)# escreva e execute names(dados_marketing_limpos) e verifique os novos nomes 
# das variaveis/colunas
names(dados_marketing_limpos)



# Exercicio 4 -------------------------------------------------------------

 
dados_marketing_limpos |>
  select(data, mes, gasto_tv, gasto_radio, promocao, receita_vendas)


# Exercicio 5 -------------------------------------------------------------

# cria a variavel gasto_total
dados_marketing_limpos |>
  mutate(
    gasto_total = gasto_tv + gasto_radio + gasto_redes_socias + gasto_email)

# exibir as colunas

dados_marketing_limpos |>
  select(data, mes, gasto_total, receita_vendas)

# visualiza o objeto no RStudio
View(dados_marketing_limpos)



# Exercicio 6 -------------------------------------------------------------

# cria duas novas variaveis com nomes mais descritivos
dados_marketing_limpos <- dados_marketing_limpos |>
  mutate(
    status_promocao = ifelse(promocao == 1, "Com promoção", "Sem promoção"),
    status_concorrencia = ifelse(
      atividade_concorrente == 1,
      "Com concorrência",
      "Sem concorrência"
    )
  )

# mostra as novas variaveis
dados_marketing_limpos |>
  select(promocao, status_promocao, atividade_concorrente, status_concorrencia)


# visualiza o objeto no RStudio
View(dados_marketing_limpos)




# Exercicio 7 -------------------------------------------------------------

# define o caminho relativo para salvar o arquivo rds
caminho_rds <- here("dados/limpos/dados_marketing_limpos.rds")

# salva os dados limpos no formato rds
write_rds(dados_marketing_limpos, caminho_rds)

# visualiza a base de dados no RStudio
View(dados_marketing_limpos)






# Exercicio 8 -------------------------------------------------------------
# filtra semanas com promocao e receita maior que 1000
dados_marketing_limpos |>
  filter(promocao == 1 & receita_vendas > 1000) |>
  select(data, mes, receita_vendas, status_promocao)





# Exercicio 9 -------------------------------------------------------------
# cria um objeto com o resumo dos dados por mês
resumo_mensal <- dados_marketing_limpos |>
  group_by(mes) |>
  summarise(
    receita_media = mean(receita_vendas),
    receita_total = sum(receita_vendas),
    gasto_total_medio = mean(gasto_total),
    semanas_com_promocao = sum(promocao)
  ) |>
  arrange(desc(receita_media))

# mostra o resultado ordenado
resumo_mensal

# visualiza o resultado no RStudio
View(resumo_mensal)

# os tres meses com maior receita media sao:
# mes 12, mes 11 e mes 10