# load packages
source("Setup.R")
lol = c('baba','mama','dada','nini','wapi') #. for tests
values = c('easy','medium','hard')#. for tests
ingredient_sep <- unlist(str_extract_all(hunder_rows$NER,  "\"([^\"]*)\""))
##shinyApp

# UI (user interface)
my_ui <-fluidPage(
  #background set up
  setBackgroundColor(color = "ghostwhite",
                     gradient = 'radial',
                     direction = c('top','left')),
  # Application title
  titlePanel("Product bundling"),
  # Sidebar with a slider input for number of cells
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "cells",
                  label = "Price range",
                  min = 1,
                  max = 50,
                  value = 15),
      textInput(inputId = "category_x",#The input slot that will be used to access the value.
                label = "Product_category"),
      textInput(inputId = "feature_2",
                label = "feature2"),
      selectizeInput(inputId = 'lol',label = 'Ingredient list',choices = ingredient_sep, options = list(maxItems = 5,placeholder = 'select an ingredient',create = T)),
      selectizeInput('difficulty',label = 'Difficulty',choices = values,
                     options = list(maxItems = 3,
                                    placeholder = 'select a difficulty',
                                    create = T)),
      actionButton(inputId='button', # generate recipe
                   label ='Get my recipe ! ',
                   icon = icon('list'))),

    # Show a plot, NN of product bundles
    mainPanel(textOutput('lol'),
              textOutput('difficulty'),
             DT::dataTableOutput('taBle'))
  )
)

install.packages('DT')
library('DT')
## server

server<-function(input,output){
  # define data

  # user input understood by the app
  output$lol<-renderText({input$lol}) # list all ingredients selected
  output$difficulty<-renderText({input$difficulty})# list difficulty


  #show list of recipces when clicking on button
  y<-reactive(input$difficulty) %>% bindEvent(input$button)

  # load dataset
  x<-reactive(as.data.frame(subset_10_first) %>% filter(Difficulty == input$difficulty)) %>%
                bindEvent(input$button)  #

  output$taBle<-DT::renderDataTable({
    # call data
    DT::datatable(x())})
}





## run the app

shinyApp(my_ui,server)

