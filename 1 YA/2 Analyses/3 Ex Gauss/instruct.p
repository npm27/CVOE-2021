# 	A line begining with # -Hash- is ignored (for comments)
# 	Text lines cannot be followed by comments, numeric parameters can.
#
#	SAMPLE INSTRUCTION FILE
#	This file contains intstructions to start an analysis.
#	Format is very strict.
#
################################################################
# 	First, present the input data file name.
Practice.txt
#
################################################################
# 	Second is the output file stem (no extension)
#	creates:
#	  *.par for best-fitting parameters and standard errors correlations
#	  *.oe = observed and expected quantiles/vincentiles/raw
#
practice
#
################################################################
#	Third 
1	Measurement unit size, in general 1 ms for RT.
#       Fourth: Mode: 0 = silent running, 1= one output/cell, 
# 2 = trace fit, >7 conditional trace mode.
1
#
################################################################
#	Fifth to seventh, convergence parameters,
#	Parameters can be changed while fitting is running in trace mode
1.e-9   Proportional objective function change tolerance
1.e-5   Proportional L(inf)-norm tolerance,
#		i.e. all parameters must change less than this
250     Maximum number of iterations allowed in one search
#
################################################################
#	Eighth,
1       Type of distribution to fit (1=ExGaus, 2=Weibull, 3=LogNormal, 4=Gumbel,5=Wald)
#          0=none, remaining of this file is ignored. 
#
################################################################
#	Ninth
2	Fit to 1=raw data, 2=quantile, following lines ignored if 1 on this line.
#       For next parameter line, 0=>precalculated quantiles, 1=>maximum number of quantiles, 
#       2=> fixed number of evenly spaced quantiles, 3=>specify p values, one per line, start #with 0 end with 1
1



