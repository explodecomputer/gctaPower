library(shiny)
library(knitr)

source("functions.R")


makeTable <- function(o)
{
	data.frame(
		Parameters = c("NCP", "Standard error", "Power"),
		Values     = c(o$ncp, o$se, o$power)
	)
}


shinyServer(function(input, output)
{

	output$uni_qt <- renderTable({
		o <- calcUniQt(
			n     = input$n_uni_qt, 
			hsq   = input$hsq_uni_qt, 
			alpha = input$alpha_uni_qt
		)
		a <- makeTable(o)
		return(a)
	})

	output$uni_cc <- renderTable({
		o <- calcUniCc(
			ncase    = input$ncase_uni_cc, 
			ncontrol = input$ncontrol_uni_cc, 
			hsq      = input$hsq_uni_cc,
			K        = input$pv_uni_cc,
			alpha    = input$alpha_uni_cc
		)
		a <- makeTable(o)
		return(a)
	})

	output$bi_qt <- renderTable({
		o <- calcBiQt(
			n1      = input$n_bi_qt1, 
			n2      = input$n_bi_qt2, 
			hsq1    = input$hsq_bi_qt1, 
			hsq2    = input$hsq_bi_qt2, 
			rg      = input$rg_bi_qt, 
			rp      = input$rp_bi_qt, 
			overlap = input$overlap_bi_qt, 
			alpha   = input$alpha_bi_qt
		)
		a <- makeTable(o)
		return(a)
	})


	output$bi_cc <- renderTable({
		o <- calcBiCc(
			ncase1    = input$ncase_bi_cc1,
			ncase2    = input$ncase_bi_cc2,
			ncontrol1 = input$ncontrol_bi_cc1, 
			ncontrol2 = input$ncontrol_bi_cc2,
			hsq1      = input$hsq_bi_cc1, 
			hsq2      = input$hsq_bi_cc2,
			K1        = input$pv_bi_cc1, 
			K2        = input$pv_bi_cc2,
			rg        = input$rg_bi_cc,
			overlap   = input$overlap_bi_cc,
			alpha     = input$alpha_bi_cc
		)
		a <- makeTable(o)
		return(a)
	})

	output$bi_qtcc <- renderTable({
		o <- calcBiQtCc(
			n        = input$n_bi_qtcc, 
			ncase    = input$ncase_bi_qtcc, 
			ncontrol = input$ncontrol_bi_qtcc, 
			hsq1     = input$hsqqt_bi_qtcc, 
			hsq2     = input$hsqcc_bi_qtcc, 
			K        = input$pvcc_bi_qtcc, 
			rg       = input$rg_bi_qtcc, 
			overlap  = input$overlap_bi_qtcc, 
			alpha    = input$alpha_bi_qtcc
		)
		a <- makeTable(o)
		return(a)
	})

})