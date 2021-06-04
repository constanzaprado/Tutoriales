
library(tidyverse)

# Parentesis --------------------------------------------------------------

modelo <- lm(Sepal.Length ~ ., data = iris)
MASS::stepAIC(modelo, direction = "backward")

# Introduccion a Tidyverse ------------------------------------------------

data <- iris

## Vieja Escuela
mean(data$Sepal.Length)

## Escuela Nueva
data$Sepal.Length %>% mean() %>% round(2)

## SHIFT + CMD + M
## SHIFT + CTR + M

# Manipulacion de Bases de datos ------------------------------------------

## select, filter, mutate, arrange, group by, etc

data[, names(data) %in% c("Sepal.Length", "Species")]
data[, c(1, 5)]
data$Sepal.Length

data %>% dplyr::select(Sepal.Length, Species)
data %>% dplyr::filter(Species == "setosa")
data %>% dplyr::arrange(Petal.Length)
data %>% dplyr::arrange(desc(Petal.Length)) 
data %>% dplyr::mutate(Largo_Total = Sepal.Length + Petal.Length)

data %>% 
  dplyr::group_by(Species) %>% 
  dplyr::summarise(Promedio = mean(Sepal.Length))

## aggregate

data %>% 
  dplyr::summarise(Promedio = mean(Sepal.Length))

### Concatenamos

data_modificada <- data %>% 
  dplyr::select(Sepal.Length, Petal.Length, Species) %>% 
  dplyr::arrange(Sepal.Length) %>% 
  dplyr::mutate(Largo_Total = Sepal.Length + Petal.Length) %>% 
  dplyr::group_by(Species) %>% 
  dplyr::summarise(Promedio_Sepalo = mean(Sepal.Length),
                   Promedio_Petalo = mean(Petal.Length),
                   Promedio_Total = mean(Largo_Total))

### Extra
# inner_join() left_join() full_join() anti_join() inner_join()

data <- data %>% 
  dplyr::left_join(data_modificada, by = "Species")







