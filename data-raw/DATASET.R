#' Recipe data from Kaggle
#'
#' @format ## Recipes
#' A data frame with 2,231,142 rows and 6 ccolumns:
#' \describe{
#'   \item{title}{1312871 unique values}
#'   \item{ingriedients}{2226362 unique values}
#'   \item{directions}{2211644 unique values}
#'   \item{link}{2231142 unique values}
#'   \item{source}{Gathered 74%, Recipes1M 26%}
#'   \item{NER}{2133496 unique values}
#' }
#' @source <https://www.kaggle.com/datasets/paultimothymooney/recipenlg?resource=download&select=RecipeNLG_dataset.csv>
"recipes"


usethis::use_data(DATASET, overwrite = TRUE)
