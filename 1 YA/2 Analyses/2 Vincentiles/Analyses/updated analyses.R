##start w/ trial level
dat = read.csv("vin trials data.csv")

options(scipen = 999)

library(ez)
library(reshape)
library(splitstackshape)

tapply(dat$mean, dat$type, mean)
tapply(dat$mean, dat$bin, mean)

tapply(dat$mean, list(dat$bin, dat$type), mean)

dat$bin = as.character(dat$bin)

model1 = ezANOVA(dat,
        wid = Subject,
        within = .(type, bin),
        dv = mean,
        type = 3,
        detailed = T)

model1$ANOVA$MSE = model1$ANOVA$SSd/model1$ANOVA$DFd
model1$ANOVA$MSE

model1

####Now for Costs####
dat4 = read.csv("ya costs analysis.csv")

dat5 = cSplit(dat4, "type", "_")

colnames(dat5)[4:5] = c("presentation", "cost")

dat5$bin = as.character(dat5$bin)

##first do an overall anova
model4 = ezANOVA(dat5,
                 wid = Subject,
                 within = .(bin, presentation, cost),
                 dv = mean,
                 detailed = T,
                 type = 3)

model4$ANOVA$MSE = model4$ANOVA$SSd/model4$ANOVA$DFd
model4$ANOVA$MSE

model4 #three-way is sig!

##And do local costs
dat6 = subset(dat5,
              dat5$cost == "local")

dat6$bin = as.character(dat6$bin)

tapply(dat6$mean, list(dat6$bin, dat6$presentation), mean)

model5 = ezANOVA(dat6,
                 wid = Subject,
                 within = .(bin, presentation),
                 dv = mean,
                 detailed = T,
                 type = 3)

model5$ANOVA$MSE = model5$ANOVA$SSd/model5$ANOVA$DFd
model5$ANOVA$MSE

model5

##global costs
dat7 = subset(dat5,
              dat5$cost == "global")

tapply(dat7$mean, list(dat7$bin, dat7$presentation), mean)

model6 = ezANOVA(dat7,
                 wid = Subject,
                 within = .(bin, presentation),
                 dv = mean,
                 detailed = T,
                 type = 3)

model6$ANOVA$MSE = model6$ANOVA$SSd/model6$ANOVA$DFd
model6$ANOVA$MSE

model6

####Double check error bars####
#global
m = tapply(dat7$mean, list(dat7$bin, dat7$presentation), mean)

lower = m - (tapply(dat7$mean, list(dat7$bin, dat7$presentation), mean) / 
                 sqrt(length(unique(dat7$Subject)))) * 1.96

upper = m + (tapply(dat7$mean, list(dat7$bin, dat7$presentation), mean) / 
                     sqrt(length(unique(dat7$Subject)))) * 1.96

m;upper;lower

##check local costs too
m2 = tapply(dat6$mean, list(dat6$bin, dat6$presentation), mean)

CI2 = (tapply(dat6$mean, list(dat6$bin, dat6$presentation), mean) / 
               sqrt(length(unique(dat6$Subject)))) * 1.96
m2;CI2

bin6 = subset(dat6,
            dat6$bin == 6)

bin6_alt = subset(bin6,
                  bin6$presentation == "alt")

hist(bin6_alt$mean)

mean(bin6_alt$mean)
((sd(bin6_alt$mean) / sqrt(89))) * 1.96

(mean(bin6_alt$mean)) + ((sd(bin6_alt$mean) / sqrt(89))) * 1.96

lower2 = m2 - (tapply(dat6$mean, list(dat6$bin, dat6$presentation), sd) / 
                     sqrt(length(unique(dat6$Subject)))) * 1.96

upper2 = m2 + (tapply(dat6$mean, list(dat6$bin, dat6$presentation), sd) / 
                     sqrt(length(unique(dat6$Subject)))) * 1.96

m2;upper2;lower2
