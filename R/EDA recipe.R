library("dplyr")
library("tidyr")
library(tidytext)

recipe_data = read.csv("Recipe_new.csv")

sapply(recipe_data, class)
print(recipe_data["NER"][n,1])
recipe_data["Ingriedients"] = as.list(recipe_data["NER"])

#length(recipe_data_new["4","NER"][[1]])

#Reach/print the n'th row
n=3
print(recipe_data["Ingriedients"][n,1])
list = as.list.data.frame(recipe_data["Ingriedients"][n,1])

# Create table of dataframe
recipe.tb <- as_tibble(
  data.frame(recipe_data)
)

## tokenize
recipe.tokens <- unnest_tokens(
  tbl = recipe.tb,
  output = "word",
  input = "Ingriedients",
  to_lower = TRUE,
  strip_punct = TRUE,
  strip_numeric = TRUE)
head(recipe.tokens, 10)



recipe.tokens = recipe.tokens[,!(names(recipe.tokens) %in% c("ingredients",  "directions", "link", "source", "NER"))]
as.data.frame(recipe.tokens)

require(reshape2)
x <- dcast(recipe.tokens, title ~ X, value.var = paste0("word", 1:10))
head(x)


#tryout <- dcast(recipe.tokens, X ~ title, value.var="word")
