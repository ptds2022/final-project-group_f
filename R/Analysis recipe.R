

##packages
pckg <- c('quanteda','ggwordcloud','quanteda.textplots','broom','tidytext','quanteda.textstats')
install.packages(pckg)

## ---- warning=FALSE, message=FALSE----------------
## Libraries needed for the exercises
RecipeNLG_dataset <- read_csv("../data-raw/Recipe_new.csv")
hunder_rows <- head(RecipeNLG_dataset, 1000)
ingredient_sep <- unlist(str_extract_all(hunder_rows$NER,  "\"([^\"]*)\""))
View(hunder_rows)

### Add Difficulty columns
hunder_rows$lenghts_ingredient <- lengths(gregexpr("\\W+", hunder_rows$NER)) + 1
#View(hunder_rows)

low_difficulty <- min(hunder_rows$lenghts_ingredient)
medium_difficulty <- mean(hunder_rows$lenghts_ingredient)
max_difficulty <- max(hunder_rows$lenghts_ingredient)

hunder_rows_analysis <- hunder_rows %>%
  mutate(Difficulty = case_when( lenghts_ingredient > (medium_difficulty*0.8) & lenghts_ingredient <= (medium_difficulty*1.1) ~ "medium", lenghts_ingredient > (medium_difficulty*1.1) ~ "hard", TRUE ~ "easy"))

