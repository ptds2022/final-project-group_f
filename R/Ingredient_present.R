library(stringr)
library(purrr)


myfunct <- function(input,difficulty1){

  #Create a sample data frame
  df <- data.frame(hunder_rows_analysis[c('NER','title','ingredients','Difficulty')])

  df$sugar_present <- str_detect(df$NER, "sugar")

  ingredients <- c("brown sugar", "nuts", "vanilla", "milk", "butter", "bite size shredded rice biscuits")
  df$sub_ing <- map_chr(df$NER, ~ paste(str_extract(.x, input), collapse = ", "))

  df$has_empty <- str_detect(df$sub_ing, "NA")

  df$na_count <- str_count(df$sub_ing, "NA")

  df$sub_ing_count <- str_count(df$sub_ing, ", ") + 1

  df$ingredient_count <- str_count(df$NER, ", ") + 1

  df$all_ingredients <- df$ingredient_count - (df$sub_ing_count - df$na_count)

  #yolo<-cbind(df$sub_ing,df$has_empty,df$na_count, df$sub_ing_count,
  #      df$ingredient_count, df$all_ingredients ) %>% as.data.frame()
  #View(df)
  df<- df%>% arrange(na_count, decreasing = F)  %>%
    #filter(has_empty==F)%>%
    filter(Difficulty ==difficulty1)%>% group_by()%>%
    summarise(Titles = title,
              Description = ingredients,
              Ingredients = NER,
              Difficulty = Difficulty)

  return(df)
  }


myfunct('brown sugar','medium')
