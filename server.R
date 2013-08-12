library(shiny)
library(ggplot2)
source("functions.R")

shinyServer(function(input, output)
{
	output$uni_qt <- renderText(
	{
		o <- calcUniQt(input$n_uni_qt, input$hsq_uni_qt)
		a <- paste(o$se, o$power)
		return(a)
	})

	output$uni_cc <- renderText(
	{
		o <- calcUniCc(input$ncase_uni_cc, input$ncontrol_uni_cc, input$hsq_uni_qt, input$pv_uni_qt)
		a <- paste(o$se, o$power)
		return(a)
	})

	output$bi_qt <- renderText(
	{
		"hello"
	})

	output$bi_cc <- renderText(
	{
		"hello"
	})

	output$bi_qtcc <- renderText(
	{
		"hello"
	})


})