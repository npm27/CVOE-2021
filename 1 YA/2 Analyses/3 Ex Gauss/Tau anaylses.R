####Ex-guass analysis####
##set up
#libraries
library(ez)
library(reshape)

####ANALYZE TRIAL TYPES####
dat.trial = read.csv("ex_gauss_trials.csv")

ezANOVA(data = dat.trial,
        wid = ID,
        within = .(trial, parameter),
        dv = Score,
        type = 3,
        detailed = T) #everything is significant!

####Analyze Costs####
##read in data
dat = read.csv("exgauss.csv")

summary(dat)

##Overall ANOVA
ezANOVA(data = dat,
        dv = Score,
        within = .(parameter, presentation, cost),
        wid = ID,
        type = 3,
        detailed = T) 

##local costs
dat.local = subset(dat,
                   dat$cost == "local")

ezANOVA(data = dat.local,
        dv = Score,
        within = .(parameter, presentation),
        wid = ID,
        type = 3,
        detailed = T) 

##global costs
dat.global = subset(dat,
                   dat$cost == "global")

ezANOVA(data = dat.global,
        dv = Score,
        within = .(parameter, presentation),
        wid = ID,
        type = 3,
        detailed = T) 
