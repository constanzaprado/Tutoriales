library(tidyverse)

# Introduccion ------------------------------------------------------------

Lista <- list(setosa = iris %>% dplyr::filter(Species == "setosa"),
              versicolor = iris %>% dplyr::filter(Species == "versicolor"),
              virginica = iris %>% dplyr::filter(Species == "virginica"))

Lista2 <- iris %>% split(.$Species)

### apply, tapply, lapply, sapply

lapply(Lista2, summary)

# Introduccion map --------------------------------------------------------

x <- 1:10
x %>% purrr::map(rnorm, n = 10)
x %>% purrr::map(rnorm, mean = 500, sd = 110)

x %>% purrr::map(rnorm, n = 10) %>% purrr::map_dbl(mean)

# Comparacion -------------------------------------------------------------

Lista %>% purrr::map(lm, formula = Sepal.Length ~ Petal.Length)
lapply(Lista, function(x) lm(Sepal.Length ~ Petal.Length, data = x)) 

# Mas librerias -----------------------------------------------------------

Tabla <- iris %>% 
  dplyr::group_by(Species) %>% 
  tidyr::nest() %>% 
  dplyr::mutate(regresion = purrr::map(data, lm, formula = Sepal.Length ~ .)) %>% 
  dplyr::mutate(modelo = purrr::map(regresion, broom::tidy)) %>% 
  dplyr::select(Species, modelo) %>% 
  tidyr::unnest(modelo) %>% 
  dplyr::select(Species, term, estimate) %>% 
  tidyr::spread(key = term, value = estimate)

## Para devolverse
Tabla %>% 
  tidyr::gather(key = term, value = estimate, -Species)














