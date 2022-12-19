# load packages
source("Setup.R")
install.packages('DT')
library('DT')
lol = c('baba','mama','dada','nini','wapi') #. for tests
values = c('easy','medium','hard') #. for tests

##shinyApp

# UI (user interface)
my_ui <-fluidPage(
  #background set up
  setBackgroundColor(color = "lightyellow",
                     gradient = 'radial',
                     direction = c('top','left')),
  tags$style(HTML("
      #first {
          border: 2px dashed black;
          padding: 1px
      }
      h3 {
          font-family: 'Amatic SC', cursive;
      }
      #second {
          font-family: 'Amatic SC', cursive;
      }
    ")),
  # Application title
  titlePanel("Product bundling"),
  # Sidebar with a slider input for number of cells
  sidebarLayout(
    sidebarPanel(
      fluidRow( #Added fluidRow to put the button and input field next to eachother
        column(9,

          selectizeInput(inputId = 'lol',
                         label = 'Ingredient list',
                         choices = ingredient_sep,
                         options = list(maxItems = 30, placeholder = 'select an ingredient',create = T)

                         ),
          style = "padding:1px",
          style = "padding-left:10px"),
        column(1,
          actionButton("add", "Add"),
          style = "margin-top: 26px;",
          style = "padding:0px")
        ),

      selectizeInput('difficulty',label = 'Difficulty',choices = values,
                     options = list(maxItems = 1,
                                    placeholder = 'select a difficulty',
                                    create = T)),
      actionButton(inputId='button', # generate recipe
                   label ='Get my recipe ! ',
                   icon = icon('list'))
    ),
    # Add a button to trigger the computation
    mainPanel(id = "first",
              style = paste0("padding-left: 5px;height: 90vh; overflow-x: auto; overflow-y: auto;"),
              div(style = "text-align: center", h3("Ingredient list")),
              htmlOutput('selected_values'),
              actionButton("compute_button", "Compute"),
              dataTableOutput('df_output'),
              style = "background-color: lightyellow;")
  )
)

## server

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
  observeEvent(input$compute_button, {
    # Add an output to display the data frame


      # Extract the selected values from the output of the Shiny code
      selected_values <- lapply(values$selected_values, HTML)
      ingredients <- selected_values

      # Use the selected values as the ingredients input in the separate code file
      library(stringr)
      library(purrr)
      df <- data.frame(hunder_rows['NER'])
      df$sugar_present <- str_detect(df$NER, "sugar")
      df$sub_ing <- map_chr(df$NER, ~ paste(str_extract(.x, ingredients), collapse = ", "))
      df$has_empty <- str_detect(df$sub_ing, "NA")
      df$na_count <- str_count(df$sub_ing, "NA")
      df$sub_ing_count <- str_count(df$sub_ing, ", ") + 1
      df$ingredient_count <- str_count(df$NER, ", ") + 1
      df$all_ingredients <- df$ingredient_count - (df$sub_ing_count - df$na_count)

      # Return the resulting data frame
      print(df)

      output$df_output <- renderDataTable({
        # Check if the compute button has been clicked
        req(input$df)
    })
  })

  output$difficulty<-renderText({input$difficulty})# list difficulty

  #show list of recipces when clicking on button
  y<-reactive(input$difficulty) %>% bindEvent(input$button)

  # load dataset
  x<-reactive(as.data.frame(subset_10_first) %>% filter(Difficulty == input$difficulty)) %>%
                bindEvent(input$button)  #

  output$table<-DT::renderDataTable({
    # call data
    DT::datatable(x())})
}





## run the app

shinyApp(my_ui,server)

