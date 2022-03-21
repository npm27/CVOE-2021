##start w/ trial level
dat = read.csv("vin trials data.csv")

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

dat2 = subset(dat,
              dat$type != "pure")

model2 = ezANOVA(dat2,
                 wid = Subject,
                 within = .(type, bin),
                 dv = mean,
                 type = 3,
                 detailed = T)

model2$ANOVA$MSE = model2$ANOVA$SSd/model2$ANOVA$DFd
model2$ANOVA$MSE

model2

dat3 = cSplit(dat2, "type", "_")

colnames(dat3)[4:5] = c("presentation", "trial")

model3 = ezANOVA(dat3,
                 wid = Subject,
                 within = .(trial, bin, presentation),
                 dv = mean,
                 type = 3,
                 detailed = T)

model3$ANOVA$MSE = model3$ANOVA$SSd/model3$ANOVA$DFd
model3$ANOVA$MSE

model3
