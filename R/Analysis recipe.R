RecipeNLG_dataset <- read_csv("~/Desktop/RecipeNLG_dataset.csv")
hunder_rows <- head(RecipeNLG_dataset, 100)

View(hunder_rows)

##packages 
pckg <- c('quanteda','ggwordcloud','quanteda.textplots','broom','tidytext','quanteda.textstats')
install.packages(pckg)
## ---- warning=FALSE, message=FALSE----------------
## Libraries needed for the exercises
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

crude.cp <- corpus(hunder_rows$NER) #each row = text distinct
crude.tk <- tokens( 
  crude.cp,
  remove_numbers = TRUE,
  remove_punct = TRUE,
  remove_symbols = TRUE,
  remove_separators = TRUE
  ) 

crude.tk.dfm <- dfm(crude.tk)
PO_softwares.tfidf <- dfm_tfidf(crude.tk.dfm)

tstat_key <- textstat_keyness(dfm_group(crude.tk.dfm ))
textplot_keyness(tstat_key)


### Add Difficulty columns
hunder_rows$lenghts_ingredient <- lengths(gregexpr("\\W+", hunder_rows$NER)) + 1
#View(hunder_rows)

low_difficulty <- min(hunder_rows$lenghts_ingredient)
medium_difficulty <- mean(hunder_rows$lenghts_ingredient)
max_difficulty <- max(hunder_rows$lenghts_ingredient)

hunder_rows_analysis <- hunder_rows %>% 
  mutate(Difficulty = case_when( lenghts_ingredient > (medium_difficulty/2) & lenghts_ingredient <= (medium_difficulty*1.5) ~ "medium", lenghts_ingredient > (medium_difficulty*1.5) ~ "hard", TRUE ~ "Low"))

View(hunder_rows_analysis)

###Detect from an external list (turn into an R package)

# list of ingredient for the sake of the example until we create the function
ingredient_to_detect <- c("rice", "brown", "nuts", "butter")  %>% tolower()


hunder_rows_analysis <- hunder_rows_analysis %>% 
  mutate(Present = case_when(str_detect(NER, regex(ingredient_to_detect, ignore_case = T )) ~ 1,
                              TRUE ~ 0))

hunder_rows_CASE_TRUE_present <- subset(hunder_rows_analysis,
                                        hunder_rows_analysis$Present == "1")

head(hunder_rows_CASE_TRUE_present, 10)


###### FIRST TRY - NO NEED TO ADAPT IT LOOK AT THE SECOND TRY

my_little_function <- function(x) {
  
  #input
  tolower(x)
  
  hunder_rows <- head(RecipeNLG_dataset, 100)
  crude.cp <- corpus(hunder_rows$NER) #each row = text distinct
  crude.tk <- tokens( 
    crude.cp,
    remove_numbers = TRUE,
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_separators = TRUE
  ) 
  
  ### Add Difficulty columns & Use mutate to compute the matchs
  hunder_rows$lenghts_ingredient <- lengths(gregexpr("\\W+", hunder_rows$NER)) + 1

  low_difficulty <- min(hunder_rows$lenghts_ingredient)
  medium_difficulty <- mean(hunder_rows$lenghts_ingredient)
  max_difficulty <- max(hunder_rows$lenghts_ingredient)
  
  hunder_rows_analysis <- hunder_rows %>% 
    mutate(Difficulty = case_when( lenghts_ingredient > (medium_difficulty/2) & lenghts_ingredient <= (medium_difficulty*1.5) ~ "medium", lenghts_ingredient > (medium_difficulty*1.5) ~ "hard", TRUE ~ "Low"),
           Present = case_when(str_detect(NER, regex(x, ignore_case = T )) ~ 1, TRUE ~ 0))
  
  
  subset_10_first <- subset(hunder_rows_analysis,hunder_rows_analysis$Present == "1")
  
  return(head(subset_10_first, 10))
}


###### Second TRY

my_little_function_2 <- function(x, difficulty) {
  
  #input
  tolower(x)
  as.character(difficulty) %>% tolower()
  
  # Token
  hunder_rows <- head(RecipeNLG_dataset, 100)
  crude.cp <- corpus(hunder_rows$NER) #each row = text distinct
  crude.tk <- tokens( 
    crude.cp,
    remove_numbers = TRUE,
    remove_punct = TRUE,
    remove_symbols = TRUE,
    remove_separators = TRUE
  ) 
  
  ### Add Difficulty columns & Use mutate to compute the matchs
  hunder_rows$lenghts_ingredient <- ntoken(crude.tk)
  
  low_difficulty <- min(hunder_rows$lenghts_ingredient)
  medium_difficulty <- mean(hunder_rows$lenghts_ingredient)
  max_difficulty <- max(hunder_rows$lenghts_ingredient)
  
  hunder_rows_analysis <- hunder_rows %>% 
    mutate(Difficulty = case_when( lenghts_ingredient > (medium_difficulty/2) & lenghts_ingredient <= (medium_difficulty*1.5) ~ "medium", lenghts_ingredient > (medium_difficulty*1.5) ~ "hard", TRUE ~ "easy"),
           Present = case_when(str_detect(NER, regex(x, ignore_case = T )) ~ 1, TRUE ~ 0))
  
  subset_10_first <- subset(hunder_rows_analysis,hunder_rows_analysis$Present == "1")
  # For difficulty filter
  
  if (difficulty == "medium" | difficulty == "Medium") {
    subset_10_first <- subset(subset_10_first,subset_10_first$Difficulty == "medium") }
  else if (difficulty == "hard" | difficulty == "Hard") {
    subset_10_first <- subset(subset_10_first,subset_10_first$Difficulty == "hard")  }
  else if (difficulty == "easy" | difficulty == "Easy") {
    subset_10_first <- subset(subset_10_first,subset_10_first$Difficulty == "easy")  }
  else {
    print("there's no such recipe")
  }
   
  return(head(subset_10_first, 10))
}

my_little_function_2(ingredient_to_detect, "Medium")
