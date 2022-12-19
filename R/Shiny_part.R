# load packages
source("R/Setup.R")
source('R/Ingredient present.R')
install.packages('DT')
library('DT')
lol = c('baba','mama','dada','nini','wapi') #. for tests
values = c('easy','medium','hard') #. for tests

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
      selectizeInput(inputId = 'lol',label = 'Ingredient list',choices = ingredient_sep, options = list(maxItems = 30, placeholder = 'select an ingredient',create = T)),
      selectizeInput('difficulty',label = 'Difficulty',choices = values,
                     options = list(maxItems = 1,
                                    placeholder = 'select a difficulty',
                                    create = T)),
      actionButton(inputId='button', # generate recipe
                   label ='Get my recipe ! ',
                   icon = icon('list'))
    ),
<<<<<<< Updated upstream
    mainPanel(textOutput('lol'),
              textOutput('difficulty'))
=======
<<<<<<< Updated upstream
    mainPanel(id = "first",
              style = paste0("padding-left: 5px;height: 90vh; overflow-x: auto; overflow-y: auto;"),
              div(style = "text-align: center", h3("Ingredient list")),
              htmlOutput('selected_values'), style = "background-color: lightyellow;")
=======
<<<<<<< Updated upstream
    mainPanel(textOutput('lol'),
              textOutput('difficulty'))
>>>>>>> Stashed changes
>>>>>>> Stashed changes
  )
=======
    mainPanel(id = "first",
              style = paste0("padding-left: 5px;height: 90vh; overflow-x: auto; overflow-y: auto;"),
              div(style = "text-align: center", h3("Ingredient list")),
              htmlOutput('selected_values'),
              style = "background-color: lightyellow;")
  ),
  fluidRow(column(4), h4('List of Recipes'),
           width = 4, height = 2,
           dataTableOutput('taBle'),offset = 6),
  fluidRow(column(6,h4('X'),
                  textOutput('image_i'),width = 4, height = 2,
                  offset = 2),
           column(9,h4 ('Y'),
                textOutput('recette'),width = 4,
                height = 2))
>>>>>>> Stashed changes
)

## server

server<-function(input,output){
  # define data

  # user input understood by the app
  output$lol<-renderText({input$lol}) # list all ingredients selected
  output$difficulty<-renderText({input$difficulty})# list difficulty

  #my_little_function_2({input$lol}, {input$difficulty})

  #show list of recipces when clicking on button
  y<-reactive(input$difficulty) %>% bindEvent(input$button)

  # load dataset
  #if(grepl(input$lol,subset_10_first$NER==TRUE)){

  x<-reactive(as.data.frame(subset_10_first) %>%
                mutate(actionButton(inputId = 'sexo',label= 'More') %>%
                filter(Difficulty == input$difficulty)) %>%
                bindEvent(input$button))

  output$taBle<-DT::renderDataTable({
    # call data
    DT::datatable(x())})

  #output$image<- renderText({hbjg})
  #output$recette<-renderText({jjk})
  }


## run the app

shinyApp(my_ui,server)




############# attempts ################


server<-function(input,output, session){ #added session
  # Initialize reactive values to store the inputs
  values <- reactiveValues(selected_values = character(0))


  # user input understood by the app
  # Observe the "add" button
  observeEvent(input$add, { #added observeEvent to make the button interactive with the input field

    # Get the selected value from the input
    selected_values <- input$lol

    # Do something with the selected value
    # For example, you can update the selectizeInput choices with the selected value
    #updateSelectizeInput(session, "lol", choices = c(ingredient_sep, selected_values))

    values$selected_values <- c(values$selected_values, selected_values)


    updateSelectizeInput(session, "lol", choices = ingredient_sep, selected = NULL)

    print(values$selected_values)

    output$selected_values <- renderText({
      paste("<ul style='list-style-type: square; font-size: 20px'>",
            paste("<li>", lapply(values$selected_values, HTML), "</li>", "<hr style='border: 1px dashed #333; margin: 5px 0'>", collapse = ""),
            "</ul>", collapse = "")
    })
  })

  output$difficulty<-renderText({input$difficulty})# list difficulty


  # get my recipee button
  observeEvent(input$button, {
    diff_values <- input$difficulty

    values$diff_values <- c(diff_values)
    })




  #show list of recipces when clicking on button
  y<-reactive(input$difficulty) %>% bindEvent(input$button)

  # load dataset
  #if(grepl(input$lol,subset_10_first$NER==TRUE)){

  x<-reactive(as.data.frame(subset_10_first) %>%
                mutate(Actions = actionButton(inputId = 'button',label= 'More')) %>%
                filter(Difficulty == 'medium') %>%
                bindEvent(input$button))


  y<-reactive(myfunct(values$selected_values,values$diff_values)) %>% bindEvent(input$button)

  output$taBle<-DT::renderDataTable({
    # call data
    DT::datatable(y())})

  #output$image<- renderText({hbjg})
  #output$recette<-renderText({jjk})
}

shinyApp(my_ui,server)

