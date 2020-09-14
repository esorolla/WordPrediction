# Load libraries ----
library(shiny)

# Load data ----
bigram <<- read.csv(file = 'bigram.csv',stringsAsFactors = FALSE,encoding='UTF-8')
trigram <<- read.csv(file = 'trigram.csv',stringsAsFactors = FALSE,encoding='UTF-8')
fourgram <<- read.csv(file = 'fourgram.csv',stringsAsFactors = FALSE,encoding='UTF-8')


# Load external functions ----
source("prediction.R")


# Define UI for application that predicts next word
ui <- fluidPage(
    
    # Application title
    titlePanel("Word prediction App"),

    tabsetPanel(
        tabPanel("Documentation", includeHTML("include.html")),
        tabPanel("App", 
                 textInput("inText", "Write in lowercase:", value = "Text", width = NULL, placeholder = NULL),
                 h2("Prediction:"),
                 verbatimTextOutput("outText")
        )
    )
)


# Define server logic required to predict the word
server <- function(input, output) {

    output$outText <- renderText({
        prediction(input$inText)
    })

}

shinyApp(ui, server)