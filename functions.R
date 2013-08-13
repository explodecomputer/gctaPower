calcUniQt <- function(n=1000, hsq=0.5)
{
	l <- list()
	l$se <- 1
	l$power <- 2
	return(l)
}

calcUniCc <- function(ncase=1000, ncontrol=1000, hsq=0.5, k=0.1)
{
	l <- list()
	l$se <- 3
	l$power <- 4
	return(l)
}

calcBiQt <- function(n1=1000, n2=1000, hsq1=0.5, hsq2=0.5, rg=0.5, rp=0.5, overlap=FALSE)
{
	l <- list()
	l$se <- 5
	l$power <- 6
	return(l)
}

calcBiCc <- function(ncase1=1000, ncase2=1000, ncontrol1=1000, ncontrol2=1000, hsq1=0.5, hsq2=0.5, k1=0.1, k2=0.1, rg=0.5, overlap=FALSE)
{
	l <- list()
	l$se <- 7
	l$power <- 8
	return(l)
}

calcBiQtCc <- function(n=1000, ncase=1000, ncontrol=1000, hsq1=0.5, hsq2=0.5, k=0.1, rg=0.5, overlap=FALSE)
{
	l <- list()
	l$se <- 9
	l$power <- 10
	return(l)
}

