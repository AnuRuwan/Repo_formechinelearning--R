library(shiny)


# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Mechine learning Jason "),
    
    
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            
            
            # Input: Select a file ----
            fileInput("file1", "Choose CSV File",
                      multiple = FALSE,
                      accept = c("text/csv",
                                 "text/comma-separated-values,text/plain",
                                 ".csv")),
            
            # Horizontal line ----
            tags$hr(),
            
            
            
           
            # adding an action button
            actionButton("go", "summery of contents", style = "color:#FFFFFF;background-color:#009dff"),
        ),
        
        
        
        # Show a plot of the generated distribution
        mainPanel(
            
            tableOutput("contents"),
            h5("number of rows and columns"),
            textOutput("norawoutput")
            
            
            
        )
    )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    
    dataInput <- reactive({
        req(input$file1)
        
        df <-read.csv(input$file1$datapath, header=FALSE) 
            
        return(df)
    })
    
    
    
    
    observeEvent(input$go, {
        dataset <- dataInput()
        colnames(dataset) <- c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species")
        dataset$Species = as.factor(dataset$Species)
        
       
       norawcolumn <- dim(dataset)
        
        output$norawoutput <- renderText({norawcolumn})
        
    })
    output$contents <- renderTable({
        
       
            return(dataInput())
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)