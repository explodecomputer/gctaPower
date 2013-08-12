calcUniQt <- function(n, hsq)
{
	l <- list()
	l$se <- 1
	l$power <- 2
	return(l)
}

calcUniCc <- function(ncase, ncontrol, hsq, k)
{
	l <- list()
	l$se <- 3
	l$power <- 4
	return(l)
}

calcBiQt <- function(n1, n2, hsq1, hsq2, rg, rp, overlap)
{
	l <- list()
	l$se <- 5
	l$power <- 6
	return(l)
}

calcBiCc <- function(ncase1, ncase2, ncontrol1, ncontrol2, hsq1, hsq2, k1, k2, rg, overlap)
{
	l <- list()
	l$se <- 7
	l$power <- 8
	return(l)
}

calcBiCc <- function(n, ncase, ncontrol, hsq1, hsq2, k, rg, overlap)
{
	l <- list()
	l$se <- 9
	l$power <- 10
	return(l)
}

