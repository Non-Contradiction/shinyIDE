#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

source("cell.R")

ui <- fixedPage(
    h2("A tiny shiny based R notebook"),
    actionButton("insertBtn", "Insert cell")
)

server <- function(input, output, session) {
    observeEvent(input$insertBtn, {
        btn <- input$insertBtn
        insertUI(
            selector = "h2",
            where = "beforeEnd",
            ui = tagList(
                h4(paste("Module no.", btn)),
                cellUI(paste0("cell", btn))
            )
        )
        
        callModule(cell, paste0("cell", btn))
    })
}

shinyApp(ui, server)
