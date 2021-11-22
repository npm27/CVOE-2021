##SET UP
library(reshape)
library(ez)

options(scipen = 999)

####Start w/ younger####
errors = read.csv("Data/YA Errors.csv")
RTs = read.csv("Data/YA RTs.csv")

####Start w/ Errors####
summary(errors)

##need pure vs switch
error1 = errors[ , c(1, 4:8)]
error2 = errors[ , c(1, 9:12)]

##reshape for anovas
error1.long = melt(data.frame(error1), id.vars = "subID")
error2.long = melt(data.frame(error2), id.vars = "subID")

colnames(error1.long)[2] = "Type"
colnames(error2.long)[2] = "Type"

colnames(error1.long)[3] = "Error"
colnames(error2.long)[3] = "Error"

####ERROR ANOVAS####
##PURE VS SWITCH
ezANOVA(error1.long,
        within = Type,
        dv = Error,
        wid = subID,
        type = 3,
        detailed = T) #main effect of type

##Post-hocs
tapply(error1.long$Error, error1.long$Type, mean) #main effect type

##Switch costs
##anova time!
ezANOVA(error2.long,
        within = Type,
        dv = Error,
        wid = subID,
        type = 3,
        detailed = T)

####Error Post-hocs####
tapply(error2.long$Error, error2.long$Type, mean) #main effect type

####RT ANOVAs####
summary(RTs)

##need pure vs switch
RTs1 = RTs[ , c(1, 4:8)]
RTs2 = RTs[ , c(1, 9:12)]

##reshape for anovas
RTs1.long = melt(data.frame(RTs1), id.vars = "subID")
RTs2.long = melt(data.frame(RTs2), id.vars = "subID")

colnames(RTs1.long)[2:3] = c("Type", "RTs")
colnames(RTs2.long)[2:3] = c("Type", "RTs")

##anova time!
ezANOVA(RTs1.long,
        within = Type,
        dv = RTs,
        wid = subID,
        type = 3,
        detailed = T)

##Post-hocs
tapply(RTs1.long$RTs, RTs1.long$Type, mean) #main effect type

##Switch costs
##anova time!
ezANOVA(RTs2.long,
        within = Type,
        dv = RTs,
        wid = subID,
        type = 3,
        detailed = T)

####Rt Post-hocs####
tapply(RTs2.long$RTs, RTs2.long$Type, mean) #main effect type

##t-tests here