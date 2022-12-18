# install and load the stringr and dplyr packages if they're not already installed
#install.packages(c("stringr", "dplyr"))
library(stringr)
library(dplyr)
library(readr)
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)
library(tidytext)
library(dplyr)
library(ggplot2)
library(broom)
library(ggwordcloud)
library(igraph)
library(quanteda)
library(quanteda.textstats)
library(quanteda.textplots)
library(stringr)

RecipeNLG_dataset <- read_csv("data-raw/Recipe_new.csv")
hunder_rows <- head(RecipeNLG_dataset, 100)

# create a data frame with a column of strings with values between parentheses
product_name <- hunder_rows["NER"]

# extract the strings between parentheses using str_extract and a regular expression
product_name <- product_name %>%
  mutate(extracted_strings = apply(product_name, 1, function(x) str_extract(x, "\\(([^)]+)\\)")))

# print the data frame
print(product_name)

ingredient_sep <- unlist(str_extract_all(hunder_rows$NER,  "\"([^\"]*)\""))

#hunder_rows$NER <- unlist(hunder_rows$NER)

#hunder_rows$NER <- lapply(hunder_rows$NER, unlist)
