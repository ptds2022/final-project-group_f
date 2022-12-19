source("R/Setup.R")
values <- c("easy", "medium", "difficult")

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
      actionButton(inputId='button', # generate recipe
                   label ='Get my recipe ! ',
                   icon = icon('list')),
      actionButton(inputId='button2', # Clear input and output
                   label ='Clear fields',
                   icon = icon('list'))
    ),
    mainPanel(id = "first",
              style = paste0("padding-left: 5px;height: 90vh; overflow-x: auto; overflow-y: auto;"),
              div(style = "text-align: center", h3("Ingredient list")),
              htmlOutput('selected_values'), style = "background-color: lightyellow;")),

  fluidRow(column(4), h4('List of Recipes'),
           width = 4, height = 2,
           dataTableOutput('taBle'),offset = 6),
  fluidRow(column(6,h4('X'),
                  textOutput('image_i'),width = 4, height = 2,
                  offset = 2),
           column(8,h4 ('Y'),
                  textOutput('recette'),width = 4,
                  height = 2))
)
