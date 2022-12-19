library(stringr)
library(purrr)

# Create a sample data frame
df <- data.frame(hunder_rows['NER'])

df$sugar_present <- str_detect(df$NER, "sugar")

ingredients <- c("brown sugar", "nuts", "vanilla", "milk", "butter", "bite size shredded rice biscuits")
df$sub_ing <- map_chr(df$NER, ~ paste(str_extract(.x, ingredients), collapse = ", "))

df$has_empty <- str_detect(df$sub_ing, "NA")
