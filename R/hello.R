# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

hello <- function() {
  print("Hello, world!")
}

just_data <- c(1,2,3,4,5)

save(just_data, file='data.rda')
# Zie slides hoe je dit moet maken.

## code to prepare supermarket_sales.csv dataset
df_recipe <- read.csv(file = "data-raw/RecipeNLG_dataset.csv")
usethis::use_data(df_recipe, overwrite = TRUE)
