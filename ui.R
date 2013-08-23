library(shiny)
library(knitr)
# source("custom_html.R")

textSidebar <- function()
{
	sidebarPanel(
		tags$head(
        tags$style(type="text/css", "body {font-size: 20px; }")),
		HTML(knit2html(text="*written by [Gibran Hemani](mailto:gibran.hemani@uq.edu.au) and [Jian Yang](mailto:jian.yang@uq.edu.au) at [CTGG](http://www.complextraitgenomics.com/)*")),
		h3("Calculate the power of univariate or bivariate GCTA analysis"),
		wellPanel(
			HTML(
				knit2html(text=
"This tool is designed to calculate the statistical power for a GCTA analysis of estimating genetic variance or genetic correlation using genome-wide SNPs. For full details on the methods please refer to:

**Visscher et al. (2013) Statistical power to detect genetic (co)variance of complex traits using SNP data in unrelated samples. Under review.**

For more information about GCTA analyses, please visit the **[GCTA webpage](http://www.complextraitgenomics.com/software/gcta/)**"
				)
			)
		),
		h3("Details"),
		wellPanel(
			HTML(
				knit2html(text=
"**Quantitative Trait (QT)**: univariate analysis of a quantitative trait

**Case-Control study (CC)**: univariate analysis of a case-control study

**QT vs QT**: bivariate analysis of two quantitative traits

**CC vs CC**: bivariate analysis of two case-control studies

**QT vs CC**: bivariate analysis of a quantitative trait and a case-control study"
				)
 			)
		),
		h3("Select the type of analysis"),
		wellPanel(
			radioButtons(
				inputId = "experiment",
				label   = "",
				c("Univariate" = "univ", "Bivariate" = "biv")
			)
		)
	)
}

outputExplanation_uni <- helpText(HTML(knit2html(text=
"**Standard error (SE):** Standard error of the SNP-heritability ($h^2$).

**NCP:** Non-centrality paramter of the chi-squared test statistic, which equal to $h^4 / (SE)^2$.

**Power:** The probability of detecting $h^2 > 0$ for the given the user-specified type I error rate and the SNP-heritability assumed in the population."
)))

outputExplanation_bi <- helpText(HTML(knit2html(text=
"**Standard error (SE):** Standard error of the genetic correlation ($r_G$).

**NCP:** Non-centrality paramter of the chi-squared test statistic, which equals to $r_G^2 / (SE)^2$.

**Power:** The probability of detecting $r_G$ for the given user-specified type I error rate, SNP-heritability, and genetic correlation assumed in the population."
)))

vpiExplanation <- helpText(HTML(knit2html(text=
"**Note:** The default value 2e-5 is obtained from the genetic relatedness between unrelated individuals using genome-wide common SNPs, which is basically the variance of the off-diagonal elements of the GRM. If your GRM is constructed from selected SNPs and/or uses differential weighting of SNPs, you can specify this by the empirical variance of the  off-diagonals of the GRM."
)))

hsqExplanation_uni <- helpText(HTML(knit2html(text=
"**Note:** The power calculation requires the true SNP-heritability, so that the power is the probability of estimating a SNP-heritability that is greater than zero."
)))

hsqExplanation_biqt <- helpText(HTML(knit2html(text=
"**Note:** The calculation of the SE of $r_G$ requires the true SNP-heritability of the trait."
)))

hsqExplanation_bicc <- helpText(HTML(knit2html(text=
"**Note:** The calculation of the SE of $r_G$ requires the true SNP-heritability of the disease."
)))


rgExplanation <- helpText(HTML(knit2html(text=
"**Note:** The power calculation of $r_G$ requires the true paramter of $r_G$, so that the power is the probability of estimating a $r_G$ that is different from zero."
)))

panelUniQt <- function()
{
	tabPanel("Quantitative Trait (QT)",
		h3("Inputs"),
		wellPanel(
			numericInput(
				inputId = "n_uni_qt",
				label   = "Sample size",
				value   = 4000,
				min     = 0,
        max = 1e30,
        step = 1000
			)
		),
		h3("Options"),
		wellPanel(
			numericInput(
				inputId = "hsq_uni_qt",
				label   = HTML(knit2html(text="Heritability, $h^2$")),
				value   = 0.2,
				min     = 0,
				max     = 1,
				step    = 0.1
			),
			hsqExplanation_uni,
			numericInput(
				inputId = "alpha_uni_qt",
				label   = HTML(knit2html(text="Type 1 error rate used in the power calculation, $\\alpha$")),
				value   = 0.05,
				min     = 5e-20,
				max     = 1, 
        step = 0.01
			),
			numericInput(
				inputId = "vpi_uni_qt",
				label   = "Variance of the SNP-derived genetic relationships",
				value   = 2e-5,
				min     = 1e-30,
				max     = 1, 
				step = 1e-5
			),
			vpiExplanation
		),
		h3("Results"),
		wellPanel(
			tableOutput("uni_qt"),
			outputExplanation_uni
		)
	)
}

panelUniCc <- function()
{
	tabPanel("Case-Control (CC) Study",
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
				inputId = "pv_uni_cc",
				label   = "Disease risk in population",
				value   = 0.1,
				min     = 0,
				max     = 1,
        step = 0.01
			)			
		),
		h3("Options"),
		wellPanel(
			numericInput(
				inputId = "hsq_uni_cc",
				label   = HTML(knit2html(text="Trait heritability (on liability scale, $h^2$)")),
				value   = 0.2,
				min     = 0,
				max     = 1,
				step = 0.1
			),
			hsqExplanation_uni,
			numericInput(
				inputId = "alpha_uni_cc",
				label   = HTML(knit2html(text="Type 1 error rate used in the power calculation, $\\alpha$")),
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
			vpiExplanation
		),
		h3("Outputs"),
		wellPanel(
			tableOutput("uni_cc"),
			outputExplanation_uni
		)
	)
}

panelBiQt <- function()
{
	tabPanel("QT vs QT",
		h3("Inputs"),
		wellPanel(
			h4("Trait #1"),
			wellPanel(
				numericInput(
					inputId = "n_bi_qt1",
					label   = "Sample size",
					value   = 4000,
					min     = 0,
					max = 1e30,
					step = 1000
				)
			),
			h4("Trait #2"),
			wellPanel(
				numericInput(
					inputId = "n_bi_qt2",
					label   = "Sample size",
					value   = 4000,
					min     = 0,
					max     = 1e30,
					step    = 1000
				)
			),
			h4("Other details"),
			wellPanel(
				numericInput(
					inputId = "rp_bi_qt",
					label   = HTML(knit2html(text="Phenotypic correlation ($r_P$)")),
					value   = 0.5,
					min     = -1,
					max     = 1,
					step    = 0.1
				),
				numericInput(
					inputId = "rg_bi_qt",
					label   = HTML(knit2html(text="Genetic correlation ($r_G$)")),
					value   = 0.5,
					min     = -1,
					max     = 1,
					step    = 0.1
				)
			)
		),
		h3("Options"),
		wellPanel(
			h4("Trait #1"),
			wellPanel(
				numericInput(
					inputId = "hsq_bi_qt1",
					label   = "Trait heritability",
					value   = 0.2,
					min     = 0,
					max     = 1,
					step    = 0.1
				),
				hsqExplanation_biqt
			),
			h4("Trait #2"),
			wellPanel(
				numericInput(
					inputId = "hsq_bi_qt2",
					label   = "Trait heritability",
					value   = 0.2,
					min     = 0,
					max     = 1,
					step    = 0.1
				),
				hsqExplanation_biqt
			),
			h4("Other details"),
			wellPanel(
				checkboxInput(
					inputId = "overlap_bi_qt",
					label   = "Are the same samples used for both traits?",
					value   = FALSE
				),
				numericInput(
					inputId = "alpha_bi_qt",
					label   = HTML(knit2html(text="Type 1 error rate used in the power calculation, $\\alpha$")),
					value   = 0.05,
					min     = 5e-20,
					max     = 1, 
					step    = 0.01
				),
				numericInput(
					inputId = "vpi_bi_qt",
					label   = "Variance of the SNP-derived genetic relatiionships",
					value   = 2e-5,
					min     = 1e-30,
					max     = 1, 
					step    = 1e-5
				),
				vpiExplanation
			)
	    ),
		h3("Outputs"),
		wellPanel(
			tableOutput("bi_qt"),
			outputExplanation_bi
		)
	)
}

panelBiCc <- function()
{
	tabPanel("CC vs CC",
		h3("Inputs"),
		wellPanel(
			h4("Case-control study #1"),
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
					inputId = "pv_bi_cc1",
					label   = "Disease risk in population",
					value   = 0.1,
					min     = 0,
					max     = 1,
					step = 0.01
				)			
			),
			h4("Case-control study #2"),
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
					inputId = "pv_bi_cc2",
					label   = "Disease risk in population",
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
					label   = HTML(knit2html(text="Genetic correlation ($r_G$)")),
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
			h4("Trait #1"),
			wellPanel(
				numericInput(
					inputId = "hsq_bi_cc1",
					label   = HTML(knit2html(text="Trait heritability (on liability scale, $h^2$)")),
					value   = 0.2,
					min     = 0,
					max     = 1,
					step = 0.1
				),
				hsqExplanation_bicc
			),
			h4("Trait #2"),
			wellPanel(			
				numericInput(
					inputId = "hsq_bi_cc2",
					label   = HTML(knit2html(text="Trait heritability (on liability scale, $h^2$)")),
					value   = 0.2,
					min     = 0,
					max     = 1,
					step = 0.1
				),
				hsqExplanation_bicc
			),
			h4("Other details"),
			wellPanel(
				checkboxInput(
					inputId = "overlap_bi_cc",
					label   = "Are the same samples used for both traits?",
					value   = FALSE
				),
				numericInput(
					inputId = "alpha_bi_cc",
					label   = HTML(knit2html(text="Type 1 error rate used in the power calculation, $\\alpha$")),
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
				vpiExplanation
			)
		),
		h3("Outputs"),
		wellPanel(
			tableOutput("bi_cc"),
			outputExplanation_bi
		)
	)
}

panelBiQtCc <- function()
{
	tabPanel("QT vs CC",
		h3("Inputs"),
		wellPanel(
			h4("Quantitative trait"),
			wellPanel(
				numericInput(
					inputId = "n_bi_qtcc",
					label   = "Sample size",
					value   = 4000,
					min     = 0,
					max = 1e30,
					step = 1000
				)
			),
			h4("Case-control study"),
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
					inputId = "pvcc_bi_qtcc",
					label   = "Disease risk in population",
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
					label   = HTML(knit2html(text="Genetic correlation ($r_G$)")),
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
			h4("Quantitative trait"),
				wellPanel(
				numericInput(
					inputId = "hsqqt_bi_qtcc",
					label   = HTML(knit2html(text="Quantitative trait heritability, $h^2$")),
					value   = 0.2,
					min     = 0,
					max     = 1,
					step = 0.1
				),
				hsqExplanation_biqt
			),
			h4("Case-control study"),
			wellPanel(
				numericInput(
					inputId = "hsqcc_bi_qtcc",
					label   = HTML(knit2html(text="Case-control trait heritability (on liability scale, $h^2$)")),
					value   = 0.2,
					min     = 0,
					max     = 1,
					step = 0.1
				),
				hsqExplanation_bicc
			),
			h4("Other details"),
			wellPanel(
				checkboxInput(
					inputId = "overlap_bi_qtcc",
					label   = "Are the same samples used for both traits?",
					value   = FALSE
				),
				numericInput(
					inputId = "alpha_bi_qtcc",
					label   = HTML(knit2html(text="Type 1 error rate used in the power calculation, $\\alpha$")),
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
				vpiExplanation
			)
		),
		h3("Outputs"),
		wellPanel(
			tableOutput("bi_qtcc"),
			outputExplanation_bi
		)
	)
}


univPanel <- tabsetPanel(panelUniQt(), panelUniCc())
bivPanel <- tabsetPanel(panelBiQt(), panelBiCc(), panelBiQtCc())


shinyUI(
	pageWithSidebar(
		headerPanel("GCTA Power Calculator"),
		textSidebar(),
		mainPanel(
			conditionalPanel(
				condition = "input.experiment == 'univ'",
				univPanel
			),
			conditionalPanel(
				condition = "input.experiment == 'biv'",
				bivPanel
			)
		)
	)
)
