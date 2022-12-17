# load packages
source("R/Setup.R")
lol = c('baba','mama','dada','nini','wapi') #for tests
values = c('easy','medium','hard')# for tests
##shinyApp

# UI (user interface)
my_ui <-fluidPage(
  #add shiny js
  useShinyjs(),

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
      selectizeInput(inputId = 'lol',label = 'Ingredient list',choices = lol, options = list(maxItems = 5,placeholder = 'select an ingredient',create = T)),
      selectizeInput('difficulty',label = 'Difficulty',choices = values,
                     options = list(maxItems = 3,
                                    placeholder = 'select a difficulty',
                                    create = T)),
      actionButton(inputId='button', #generate recipe
                   label ='Get my recipe ! ',
                   icon = icon('list'))),

    # Show a plot, NN of product bundles
    mainPanel(textOutput('lol'),
              textOutput('difficulty'),
             DT::dataTableOutput('taBle')
            # click='image',
             #click='description')),

  #add row that will display image + title of recipe selected + description
  #fluidRow(column(3,
   #               h4('Image of Recipe'),
  #                imageOutput('image'),
   #               width = 4),
    #       column(6,
     #             h4('name of recipe'),
    #              textOutput('description'),
     #             width = 4)))
    )))


## server

server<-function(input,output){
  # define data

  # user input understood by the app
  output$lol<-renderText({input$lol}) # list all ingredients selected
  output$difficulty<-renderText({input$difficulty})# list difficulty


  #show list of recipces when clicking on button
  #y<-reactive(input$difficulty) %>% bindEvent(input$button)

  # load dataset
  x<-reactive(as.data.frame(testo) %>%
                #mutate( #Actionbtn= glue('<button id="custom_btn" onclick="Shiny.onInputChange(\'button_id\', \'{testo}\')">Click</button>')
                #) %>%
    group_by()%>%dplyr::summarise(Recipe = title,
                            Difficulty = Difficulty,
                           #Actionbtn = Actionbtn,
                           Ingredients = ingredients,
                           Images = Images,
                           actionbtn=rep(actionBttn(inputId = 'mdr',label = 'testo'),4)) %>%
                             filter(Difficulty == input$difficulty)) %>%
      bindEvent(input$button)

  output$taBle<-DT::renderDataTable({
    # call data
    DT::datatable(x())})

  # add image when user click on recipe i
  output$image <- renderImage({
    reactive(testo[1,11]) %>% bindEvent(input$mdr) # if click on datatable
  })

    # add description of recipe i
  output$description <- renderText({
    reactive(testo[1,3]) %>% bindEvent(input$mdr)

  })
}

library(glue)
library(shinyjs)
install.packages("remotes")
remotes::install_github("cparsania/FungiExpresZ")


## FIND A FUCNTION that allows us to click and generate the recipe i

## run the app

shinyApp(my_ui,server)

