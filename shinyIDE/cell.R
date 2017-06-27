library(shiny)
library(ggplot2)

sandbox <- new.env()

join <- function(ls, sep = ", "){
    do.call(paste, append(ls, list(sep = sep)))
}

cellUI <- function(id) {
    ns <- NS(id)
    
    fluidRow(
        actionButton(ns("run"), "Run"),
        column(6, textAreaInput(ns("text"), "Text:", value = "1 + 1", width = "100%")),
        column(6, htmlOutput(ns("text")))
    )
}

cell <- function(input, output, session, data, left, right) {
    
    evaluation <- eventReactive(input$run, {
        evaluate(input$text, envir = sandbox)
    })
    
    output$text <- renderUI({HTML(join(evaluation()[-1], sep = '<br/>'))})
}
