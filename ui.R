library(shiny)
library(knitr)

textSidebar <- function()
{
	sidebarPanel(
		HTML(
			knit2html(text=
"*brought to you by [Gibran Hemani](mailto:gibran.hemani@uq.edu.au) and [Jian Yang](mailto:jian.yang@uq.edu.au)*

### Calculate the power of univariate or bivariate GCTA analysis

This tool is designed to calculate the statistical power for a GCTA analysis of estimating genetic variance or genetic correlation using genome-wide SNPs. For full details on the methods please refer to:

**Visscher et al. (2013) Statistical power to detect genetic (co)variance of complex traits using SNP data in unrelated samples. Under review.**
                
## [GCTA webpage](http://www.complextraitgenomics.com/software/gcta/)
                
**QT vs QT**: bivariate analysis of two quantitative traits
**CC vs CC**: bivariate analysis of two case-control studies
**QT vs CC**: bivariate analysis of a quantitative trait and a case-control study
                
                "
			)
		)
	)
}

panelUniQt <- function()
{
	tabPanel("Quantitative trait (QT)",
		h3("Inputs"),
		wellPanel(
			numericInput(
				inputId = "n_uni_qt",
				label   = "Sample size",
				value   = 4000,
				min     = 0,
        max = 1e30,
        step = 1000
			),
			numericInput(
				inputId = "hsq_uni_qt",
				label   = "Trait heritability",
				value   = 0.5,
				min     = 0,
				max     = 1,
        step = 0.1
			)
		),
		h3("Options"),
		wellPanel(
			numericInput(
				inputId = "alpha_uni_qt",
				label   = "Type 1 error rate",
				value   = 0.05,
				min     = 5e-20,
				max     = 1, 
        step = 0.01
			),
			numericInput(
			  inputId = "vpi_uni_qt",
			  label   = "Variance of the SNP-derived genetic relatiionships",
			  value   = 2e-5,
			  min     = 1e-30,
			  max     = 1, 
			  step = 1e-5
			),
			helpText(HTML(knit2html(text="**Note:** The default value 2e-5 is obtained from the genetic relatedness between unrelated individuals using common SNPs. ")))
		),
		h3("Results"),
		wellPanel(
			tableOutput("uni_qt")
		)
	)
}

panelUniCc <- function()
{
	tabPanel("Case-Control design (CC)",
		h3("Inputs"),
		wellPanel(
			numericInput(
				inputId = "ncase_uni_cc",
				label   = "Number of cases",
				value   = 2000,
				min     = 0,
        max = 1e30,
        step = 500
			),
			numericInput(
				inputId = "ncontrol_uni_cc",
				label   = "Number of controls",
				value   = 2000,
				min     = 0,
        max = 1e30,
        step = 500
			),
			numericInput(
				inputId = "hsq_uni_cc",
				label   = "Trait heritability (liability scale)",
				value   = 0.5,
				min     = 0,
				max     = 1,
        step = 0.1
			),
			numericInput(
				inputId = "pv_uni_cc",
				label   = "Prevalence",
				value   = 0.1,
				min     = 0,
				max     = 1,
        step = 0.01
			)			
		),
		h3("Options"),
		wellPanel(
		  numericInput(
		    inputId = "alpha_uni_cc",
		    label   = "Type 1 error rate",
		    value   = 0.05,
		    min     = 5e-20,
		    max     = 1, 
		    step = 0.01
		  ),
		  numericInput(
		    inputId = "vpi_uni_cc",
		    label   = "Variance of the SNP-derived genetic relatiionships",
		    value   = 2e-5,
		    min     = 1e-30,
		    max     = 1, 
		    step = 1e-5
		  ),
		  helpText(HTML(knit2html(text="**Note:** The default value 2e-5 is obtained from the genetic relatedness between unrelated individuals using common SNPs. ")))
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
					value   = 4000,
					min     = 0,
          max = 1e30,
          step = 1000
				),
				numericInput(
					inputId = "hsq_bi_qt1",
					label   = "Trait heritability",
					value   = 0.5,
					min     = 0,
					max     = 1,
          step = 0.1
				)
			),
			h4("Trait 2"),
			wellPanel(
				numericInput(
					inputId = "n_bi_qt2",
					label   = "Sample size",
					value   = 4000,
					min     = 0,
          max = 1e30,
          step = 1000
				),
				numericInput(
					inputId = "hsq_bi_qt2",
					label   = "Trait heritability",
					value   = 0.5,
					min     = 0,
					max     = 1,
          step = 0.1
				)
			),
			h4("Other details"),
			wellPanel(
				numericInput(
					inputId = "rp_bi_qt",
					label   = "Phenotypic correlation",
					value   = 0.5,
					min     = -1,
					max     = 1,
          step = 0.1
				),
				numericInput(
					inputId = "rg_bi_qt",
					label   = "Genetic correlation",
					value   = 0.5,
					min     = -1,
					max     = 1,
          step = 0.1
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
			  label   = "Type 1 error rate",
			  value   = 0.05,
			  min     = 5e-20,
			  max     = 1, 
			  step = 0.01
			),
			numericInput(
			  inputId = "vpi_bi_qt",
			  label   = "Variance of the SNP-derived genetic relatiionships",
			  value   = 2e-5,
			  min     = 1e-30,
			  max     = 1, 
			  step = 1e-5
			),
			helpText(HTML(knit2html(text="**Note:** The default value 2e-5 is obtained from the genetic relatedness between unrelated individuals using common SNPs. ")))
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
					value   = 2000,
					min     = 0,
          max = 1e30,
          step = 500
				),
				numericInput(
					inputId = "ncontrol_bi_cc1",
					label   = "Number of controls",
					value   = 2000,
					min     = 0,
					max = 1e30,
					step = 500
				),
				numericInput(
					inputId = "hsq_bi_cc1",
					label   = "Trait heritability (liability scale)",
					value   = 0.5,
					min     = 0,
					max     = 1,
          step = 0.1
				),
				numericInput(
					inputId = "pv_bi_cc1",
					label   = "Prevalence",
					value   = 0.1,
					min     = 0,
					max     = 1,
          step = 0.01
				)			
			),
			h4("Trait 2"),
			wellPanel(
				numericInput(
					inputId = "ncase_bi_cc2",
					label   = "Number of cases",
					value   = 2000,
					min     = 0,
          max = 1e30,
          step = 500
				),
				numericInput(
					inputId = "ncontrol_bi_cc2",
					label   = "Number of controls",
					value   = 2000,
					min     = 0,
          max = 1e30,
          step = 500
				),
				numericInput(
					inputId = "hsq_bi_cc2",
					label   = "Trait heritability (liability scale)",
					value   = 0.5,
					min     = 0,
					max     = 1,
          step = 0.1
				),
				numericInput(
					inputId = "pv_bi_cc2",
					label   = "Prevalence",
					value   = 0.1,
					min     = 0,
					max     = 1,
          step = 0.01
				)			
			),
			h4("Other details"),
			wellPanel(
				numericInput(
					inputId = "rg_bi_cc",
					label   = "Genetic correlation",
					value   = 0.5,
					min     = -1,
					max     = 1,
          step = 0.1
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
			  label   = "Type 1 error rate",
			  value   = 0.05,
			  min     = 5e-20,
			  max     = 1, 
			  step = 0.01
			),
			numericInput(
			  inputId = "vpi_bi_cc",
			  label   = "Variance of the SNP-derived genetic relatiionships",
			  value   = 2e-5,
			  min     = 1e-30,
			  max     = 1, 
			  step = 1e-5
			),
			helpText(HTML(knit2html(text="**Note:** The default value 2e-5 is obtained from the genetic relatedness between unrelated individuals using common SNPs. ")))
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
					value   = 4000,
					min     = 0,
          max = 1e30,
          step = 1000
				),
				numericInput(
					inputId = "hsqqt_bi_qtcc",
					label   = "Trait heritability",
					value   = 0.5,
					min     = 0,
					max     = 1,
          step = 0.1
				)
			),
			h4("Case Control Study"),
			wellPanel(
				numericInput(
					inputId = "ncase_bi_qtcc",
					label   = "Number of cases",
					value   = 2000,
					min     = 0,
          max = 1e30,
          step = 500
				),
				numericInput(
					inputId = "ncontrol_bi_qtcc",
					label   = "Number of controls",
					value   = 2000,
					min     = 0,
          max = 1e30,
          step = 500
				),
				numericInput(
					inputId = "hsqcc_bi_qtcc",
					label   = "Trait heritability (liability scale)",
					value   = 0.5,
					min     = 0,
					max     = 1,
          step = 0.1
				),
				numericInput(
					inputId = "pvcc_bi_qtcc",
					label   = "Prevalence",
					value   = 0.1,
					min     = 0,
					max     = 1,
          step = 0.01
				)			
			),
			h4("Other details"),
			wellPanel(
				numericInput(
					inputId = "rg_bi_qtcc",
					label   = "Genetic correlation",
					value   = 0.5,
					min     = -1,
					max     = 1,
          step = 0.1
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
			  label   = "Type 1 error rate",
			  value   = 0.05,
			  min     = 5e-20,
			  max     = 1, 
			  step = 0.01
			),
			numericInput(
			  inputId = "vpi_bi_qtcc",
			  label   = "Variance of the SNP-derived genetic relatiionships",
			  value   = 2e-5,
			  min     = 1e-30,
			  max     = 1, 
			  step = 1e-5
			),
			helpText(HTML(knit2html(text="**Note:** The default value 2e-5 is obtained from the genetic relatedness between unrelated individuals using common SNPs. ")))
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
