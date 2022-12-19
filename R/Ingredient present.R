library(stringr)
library(purrr)

# Create a sample data frame
df <- data.frame(hunder_rows['NER'])

df$sugar_present <- str_detect(df$NER, "sugar")

df$ingredients <- str_extract_all(df$NER, "sugar|vanilla")

# Check if all of the words are present in each cell
df$all_ingredients_present <- map_lgl(df$ingredients, function(x) all(c("sugar", "vanilla") %in% x))
