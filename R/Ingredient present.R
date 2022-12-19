library(stringr)
library(purrr)

# Create a sample data frame
df <- data.frame(hunder_rows['NER'])

df$sugar_present <- str_detect(df$NER, "sugar")

ingredients <- c("brown sugar", "nuts", "vanilla", "milk", "butter", "bite size shredded rice biscuits")
df$sub_ing <- map_chr(df$NER, ~ paste(str_extract(.x, ingredients), collapse = ", "))

df$has_empty <- str_detect(df$sub_ing, "NA")

df$na_count <- str_count(df$sub_ing, "NA")

df$sub_ing_count <- str_count(df$sub_ing, ", ") + 1

df$ingredient_count <- str_count(df$NER, ", ") + 1

df$all_ingredients <- df$ingredient_count - (df$sub_ing_count - df$na_count)
