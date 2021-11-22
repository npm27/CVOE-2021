##SET UP
library(readxl)
library(reshape)
library(ez)

options(scipen = 999)

####Start w/ younger####
young_errors = read_xlsx("Data/YA Output 10_14.xlsx", sheet = "ERRORS")
young_rts = read_xlsx("Data/YA Output 10_14.xlsx", sheet = "RTs")
#young_Zrts = read_xlsx("Data/YA Output 10_14.xlsx", sheet = "zRTs")

young_errors = young_errors[-c(78:nrow(young_errors)), ]
young_rts = young_rts[-c(78:nrow(young_rts)), ]
#young_Zrts = young_Zrts[-c(78:nrow(young_Zrts)), ]

##add age group codings
young_errors$age = rep("YA")
young_rts$age = rep("YA")
#young_Zrts$age = rep("YA")

####Now do Healthies####
healthy_errors = read_xlsx("Data/Older Healthy Output 10_14.xlsx", sheet = "Errors")
healthy_rts = read_xlsx("Data/Older Healthy Output 10_14.xlsx", sheet = "RTs")
#healthy_Zrts = read_xlsx("Data/Older Healthy Output 10_14.xlsx", sheet = "zRTs")

healthy_errors = healthy_errors[-c(37:nrow(healthy_errors)), ]
healthy_rts = healthy_rts[-c(37:nrow(healthy_rts)), ]
#healthy_Zrts = healthy_Zrts[-c(37:nrow(healthy_Zrts)), ]

##add age group codings
healthy_errors$age = rep("Healthy")
healthy_rts$age = rep("Healthy")
#healthy_Zrts$age = rep("Healthy")

####And finally MCIs####
mci_errors = read_xlsx("Data/Older MCI Output 10_14.xlsx", sheet = "Errors")
mci_rts = read_xlsx("Data/Older MCI Output 10_14.xlsx", sheet = "RTs")
#mci_Zrts = read_xlsx("Data/Older MCI Output 10_14.xlsx", sheet = "zRTs")

mci_errors = mci_errors[-c(27:nrow(mci_errors)), ]
mci_rts = mci_rts[-c(27:nrow(mci_rts)), ]
#mci_Zrts = mci_Zrts[-c(27:nrow(mci_Zrts)), ]

##add age group codings
mci_errors$age = rep("MCI")
mci_rts$age = rep("MCI")
#mci_Zrts$age = rep("MCI")

####Combine on age group####
errors = rbind(healthy_errors, young_errors, mci_errors)
RTs = rbind(healthy_rts, young_rts, mci_rts)
#ZRTs = rbind(healthy_Zrts, young_Zrts, mci_Zrts)

####Start w/ Errors####
summary(errors)

##need pure vs switch
error1 = errors[ , c(1, 13, 4:8)]
error2 = errors[ , c(1, 13, 9:12)]

##reshape for anovas
error1.long = melt(data.frame(error1), id.vars = c("subID", "age"))
error2.long = melt(data.frame(error2), id.vars = c("subID", "age"))

colnames(error1.long)[3:4] = c("Type", "Error")
colnames(error2.long)[3:4] = c("Type", "Error")

##anova time!
ezANOVA(error1.long,
        within = Type,
        between = age,
        dv = Error,
        wid = subID,
        type = 3,
        detailed = T)

##Post-hocs
tapply(error1.long$Error, error1.long$age, mean) #main effect age
tapply(error1.long$Error, error1.long$Type, mean) #main effect type
tapply(error1.long$Error, list(error1.long$Type, error1.long$age), mean) #interaction

##Switch costs
##anova time!
ezANOVA(error2.long,
        within = Type,
        between = age,
        dv = Error,
        wid = subID,
        type = 3,
        detailed = T)

##Post-hocs
tapply(error2.long$Error, error2.long$age, mean) #main effect age
tapply(error2.long$Error, error2.long$Type, mean) #main effect type
tapply(error2.long$Error, list(error2.long$Type, error2.long$age), mean) #interaction

####RTs####
summary(RTs)

##need pure vs switch
RTs1 = RTs[ , c(1, 13, 4:8)]
RTs2 = RTs[ , c(1, 13, 9:12)]

##reshape for anovas
RTs1.long = melt(data.frame(RTs1), id.vars = c("subID", "age"))
RTs2.long = melt(data.frame(RTs2), id.vars = c("subID", "age"))

colnames(RTs1.long)[3:4] = c("Type", "RTs")
colnames(RTs2.long)[3:4] = c("Type", "RTs")

##anova time!
ezANOVA(RTs1.long,
        within = Type,
        between = age,
        dv = RTs,
        wid = subID,
        type = 3,
        detailed = T)

##Post-hocs
tapply(RTs1.long$RTs, RTs1.long$age, mean) #main effect age
tapply(RTs1.long$RTs, RTs1.long$Type, mean) #main effect type
tapply(RTs1.long$RTs, list(RTs1.long$Type, RTs1.long$age), mean) #interaction

##Switch costs
##anova time!
ezANOVA(RTs2.long,
        within = Type,
        between = age,
        dv = RTs,
        wid = subID,
        type = 3,
        detailed = T)

##Post-hocs
tapply(RTs2.long$RTs, RTs2.long$age, mean) #main effect age
tapply(RTs2.long$RTs, RTs2.long$Type, mean) #main effect type
tapply(RTs2.long$RTs, list(RTs2.long$Type, RTs2.long$age), mean) #interaction