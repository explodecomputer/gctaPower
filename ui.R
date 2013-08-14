library(shiny)
library(knitr)

textSidebar <- function()
{
	sidebarPanel(
		HTML(
			knit2html(text=
"*brought to you by [CTGG](http://complextraitgenomics.com)*

Hi Jian

### Calculate the power of univariate or bivariate GCTA analysis

This tool can be used to calculate the statistical power for a GCTA analysis from user-supplied sample sizes and trait heritabilities. For full details on the methods please refer to:

[Yang et al. 2013. **GCTA Power Calculator**. *Some journal* 1(1) 1-10](http://pubmed.com)"
			)
		)
	)
}

panelUniQt <- function()
{
	tabPanel("Quantitative",
		h3("Inputs"),
		wellPanel(
			numericInput(
				inputId = "n_uni_qt",
				label   = "Sample size",
				value   = 1000,
				min     = 0
			),
			numericInput(
				inputId = "hsq_uni_qt",
				label   = "Trait heritability",
				value   = 0.5,
				min     = 0,
				max     = 1
			)
		),
		h3("Options"),
		wellPanel(
			numericInput(
				inputId = "alpha_uni_qt",
				label   = "Type 1 error (alpha)",
				value   = 0.05,
				min     = 1e-6,
				max     = 0.99
			)		
		),
		h3("Results"),
		wellPanel(
			tableOutput("uni_qt")
		)
	)
}

panelUniCc <- function()
{
	tabPanel("Case Control",
		h3("Inputs"),
		wellPanel(
			numericInput(
				inputId = "ncase_uni_cc",
				label   = "Number of cases",
				value   = 1000,
				min     = 0
			),
			numericInput(
				inputId = "ncontrol_uni_cc",
				label   = "Number of controls",
				value   = 1000,
				min     = 0
			),
			numericInput(
				inputId = "hsq_uni_cc",
				label   = "Trait heritability (liability scale)",
				value   = 0.5,
				min     = 0,
				max     = 1
			),
			numericInput(
				inputId = "pv_uni_cc",
				label   = "Prevalence",
				value   = 0.5,
				min     = 0,
				max     = 1
			)			
		),
		h3("Options"),
		wellPanel(
			numericInput(
				inputId = "alpha_uni_cc",
				label   = "Type 1 error (alpha)",
				value   = 0.05,
				min     = 1e-6,
				max     = 0.99
			)		
		),
		h3("Outputs"),
		wellPanel(
			tableOutput("uni_cc")
		)
	)
}

panelBiQt <- function()
{
	tabPanel("QT vs QT",
		h3("Inputs"),
		wellPanel(
			h4("Trait 1"),
			wellPanel(
				numericInput(
					inputId = "n_bi_qt1",
					label   = "Sample size",
					value   = 1000,
					min     = 0
				),
				numericInput(
					inputId = "hsq_bi_qt1",
					label   = "Trait heritability",
					value   = 0.5,
					min     = 0,
					max     = 1
				)
			),
			h4("Trait 2"),
			wellPanel(
				numericInput(
					inputId = "n_bi_qt2",
					label   = "Sample size",
					value   = 1000,
					min     = 0
				),
				numericInput(
					inputId = "hsq_bi_qt2",
					label   = "Trait heritability",
					value   = 0.5,
					min     = 0,
					max     = 1
				)
			),
			h4("Other details"),
			wellPanel(
				numericInput(
					inputId = "rp_bi_qt",
					label   = "Phenotypic correlation",
					value   = 0.5,
					min     = -1,
					max     = 1
				),
				numericInput(
					inputId = "rg_bi_qt",
					label   = "Genetic correlation",
					value   = 0.5,
					min     = -1,
					max     = 1
				)
			)
		),
		h3("Options"),
		wellPanel(
			checkboxInput(
				inputId = "overlap_bi_qt",
				label   = "Are the same samples used for both traits?",
				value   = FALSE
			),
			numericInput(
				inputId = "alpha_bi_qt",
				label   = "Type 1 error (alpha)",
				value   = 0.05,
				min     = 1e-6,
				max     = 0.99
			)		
		),
		h3("Outputs"),
		wellPanel(
			tableOutput("bi_qt")
		)
	)
}

panelBiCc <- function()
{
	tabPanel("CC vs CC",
		h3("Inputs"),
		wellPanel(
			h4("Trait 1"),
			wellPanel(
				numericInput(
					inputId = "ncase_bi_cc1",
					label   = "Number of cases",
					value   = 1000,
					min     = 0
				),
				numericInput(
					inputId = "ncontrol_bi_cc1",
					label   = "Number of controls",
					value   = 1000,
					min     = 0
				),
				numericInput(
					inputId = "hsq_bi_cc1",
					label   = "Trait heritability (liability scale)",
					value   = 0.5,
					min     = 0,
					max     = 1
				),
				numericInput(
					inputId = "pv_bi_cc1",
					label   = "Prevalence",
					value   = 0.5,
					min     = 0,
					max     = 1
				)			
			),
			h4("Trait 2"),
			wellPanel(
				numericInput(
					inputId = "ncase_bi_cc2",
					label   = "Number of cases",
					value   = 1000,
					min     = 0
				),
				numericInput(
					inputId = "ncontrol_bi_cc2",
					label   = "Number of controls",
					value   = 1000,
					min     = 0
				),
				numericInput(
					inputId = "hsq_bi_cc2",
					label   = "Trait heritability (liability scale)",
					value   = 0.5,
					min     = 0,
					max     = 1
				),
				numericInput(
					inputId = "pv_bi_cc2",
					label   = "Prevalence",
					value   = 0.5,
					min     = 0,
					max     = 1
				)			
			),
			h4("Other details"),
			wellPanel(
				numericInput(
					inputId = "rg_bi_cc",
					label   = "Genetic correlation",
					value   = 0.5,
					min     = -1,
					max     = 1
				),
				helpText(HTML(knit2html(text="**Note:** Here we assume that the genetic and phenotypic correlation is the same")))
			)
		),
		h3("Options"),
		wellPanel(
			checkboxInput(
				inputId = "overlap_bi_cc",
				label   = "Are the same samples used for both traits?",
				value   = FALSE
			),
			numericInput(
				inputId = "alpha_bi_cc",
				label   = "Type 1 error (alpha)",
				value   = 0.05,
				min     = 1e-6,
				max     = 0.99
			)		
		),
		h3("Outputs"),
		wellPanel(
			tableOutput("bi_cc")
		)
	)
}

panelBiQtCc <- function()
{
	tabPanel("QT vs CC",
		h3("Inputs"),
		wellPanel(
			h4("Quantitative Trait"),
			wellPanel(
				numericInput(
					inputId = "n_bi_qtcc",
					label   = "Sample size",
					value   = 1000,
					min     = 0
				),
				numericInput(
					inputId = "hsqqt_bi_qtcc",
					label   = "Trait heritability",
					value   = 0.5,
					min     = 0,
					max     = 1
				)
			),
			h4("Case Control Trait"),
			wellPanel(
				numericInput(
					inputId = "ncase_bi_qtcc",
					label   = "Number of cases",
					value   = 1000,
					min     = 0
				),
				numericInput(
					inputId = "ncontrol_bi_qtcc",
					label   = "Number of controls",
					value   = 1000,
					min     = 0
				),
				numericInput(
					inputId = "hsqcc_bi_qtcc",
					label   = "Trait heritability (liability scale)",
					value   = 0.5,
					min     = 0,
					max     = 1
				),
				numericInput(
					inputId = "pvcc_bi_qtcc",
					label   = "Prevalence",
					value   = 0.5,
					min     = 0,
					max     = 1
				)			
			),
			h4("Other details"),
			wellPanel(
				numericInput(
					inputId = "rg_bi_qtcc",
					label   = "Genetic correlation",
					value   = 0.5,
					min     = -1,
					max     = 1
				),
				helpText(HTML(knit2html(text="**Note:** Here we assume that the genetic and phenotypic correlation is the same")))
			)
		),
		h3("Options"),
		wellPanel(
			checkboxInput(
				inputId = "overlap_bi_qtcc",
				label   = "Are the same samples used for both traits?",
				value   = FALSE
			),
			numericInput(
				inputId = "alpha_bi_qtcc",
				label   = "Type 1 error (alpha)",
				value   = 0.05,
				min     = 1e-6,
				max     = 0.99
			)		
		),
		h3("Outputs"),
		wellPanel(
			tableOutput("bi_qtcc")
		)
	)
}

shinyUI(
	pageWithSidebar(
		headerPanel("GCTA Power Calculator"),
		textSidebar(),
		mainPanel(
			tabsetPanel(
				panelUniQt(),
				panelUniCc(),
				panelBiQt(),
				panelBiCc(),
				panelBiQtCc()
			)
		)
	)
)
