
source(here::here("R/Setup.R"))
source(here::here("data-raw/"))

recipe_data <- read_csv("data-raw/Recipe_new.csv")
RecipeNLG_dataset <- read_csv("data-raw/Recipe_new.csv")

hunder_rows <- head(RecipeNLG_dataset, 10000)
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

# Text Mining
crude.cp <- corpus(hunder_rows$NER) #each row = text distinct
crude.tk <- tokens(
  crude.cp,
  remove_numbers = TRUE,
  remove_punct = TRUE,
  remove_symbols = TRUE,
  remove_separators = TRUE
)

crude.tk.dfm <- dfm(crude.tk)
crude.tfidf <-dfm_tfidf(crude.tk.dfm)

# Similarities Between Words
crude.feat <- textstat_frequency(crude.tk.dfm) %>%
  filter(rank <= 40)

crude.cos <- textstat_simil(
  crude.tk.dfm[, crude.feat$feature],
  method = "cosine",
  margin = "feature")

crude.cos.mat <- melt(as.matrix(crude.cos))

ggplot(data = crude.cos.mat, aes(x=X1, y=X2, fill=value)) +
  scale_fill_gradient2(
    low = "blue",
    high = "red",
    mid = "white",
    midpoint = 0.5,
    limit = c(0, 1),
    name = "Cosine") +
  geom_tile() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 5),
    axis.text.y = element_text(size = 5)) +
  xlab("") +
  ylab("")

### Add Difficulty columns
hunder_rows$lenghts_ingredient <- lengths(gregexpr("\\W+", hunder_rows$NER)) + 1

low_difficulty <- min(hunder_rows$lenghts_ingredient)
medium_difficulty <- mean(hunder_rows$lenghts_ingredient)
max_difficulty <- max(hunder_rows$lenghts_ingredient)

hunder_rows_analysis <- hunder_rows %>%
  mutate(Difficulty = case_when( lenghts_ingredient > (medium_difficulty/2) & lenghts_ingredient <= (medium_difficulty*1.5) ~ "medium", lenghts_ingredient > (medium_difficulty*1.5) ~ "hard", TRUE ~ "Low"))

