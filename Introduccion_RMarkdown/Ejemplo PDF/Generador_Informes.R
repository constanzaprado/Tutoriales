library(tidyverse)
library(rmarkdown)

vector <- unique(iris$Species)
for(i in 1:length(vector)) {
  rmarkdown::render(input = "Ejemplo_pdf.Rmd",
                    output_format = "pdf_document",
                    output_file = paste0("Informe_Especie_", vector[i], ".pdf"),
                    output_dir = getwd())
  print(i)
}
