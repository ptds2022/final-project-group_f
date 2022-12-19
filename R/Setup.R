#############################################
## The following loads the needed packages ##
#############################################

packages <- c(
  "knitr", "readr", "dplyr", "plyr",
  "here", # for the project's organization
  "tidyverse", "kableExtra", "microbenchmark",
  "ggplot2", "plot.matrix", "rstan", "quanteda",
  "quanteda.textstats", "lexicon", "tidytext", "reshape2",
  "rstan",'deSolve','stats',"MASS",'ModelMetrics',"reshape",
  'gganimate','ggimage','ggimage', #'transformr'
  #readRDS

  #for shiny
  "gapminder", "ggforce", "gh", "globals", "openintro", "profvis",
  "RSQLite", "shiny", "shinycssloaders", "shinyFeedback",
  "shinythemes", "testthat", "thematic", "tidyverse", "vroom",
  "waiter", "xml2", "zeallot",'shiny','shinyWidgets','DT'
)

purrr::walk(packages, library, character.only = TRUE)

######################################################
## The following sets a few option for nice reports ##
######################################################

# general options
options(
  digits = 3,
  str = strOptions(strict.width = "cut"),
  width = 69,
  tibble.width = 69,
  cli.unicode = FALSE
)

# ggplot options
theme_set(theme_light())

# knitr options
opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  cache = TRUE,
  fig.retina = 0.8, # figures are either vectors or 300 dpi diagrams
  dpi = 300,
  out.width = "70%",
  fig.align = "center",
  fig.width = 6,
  fig.asp = 0.618,
  fig.show = "hold",
  message = FALSE,
  echo = FALSE
)

##################### THis was previously the Ingredient seperation.R file ################################
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
hunder_rows <- head(RecipeNLG_dataset, 1000)

ingredient_sep <- unlist(str_extract_all(hunder_rows$NER,  "\"([^\"]*)\""))
ingredient_sep <- gsub("\"", "", ingredient_sep)

##################################################################################
## The following code creates the needed data in the environment to run the app ##
##################################################################################
source("Ingredient_present.R")
