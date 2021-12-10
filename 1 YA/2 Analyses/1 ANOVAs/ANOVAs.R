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
error1 = errors[ , c(1, 4:8)] #trials
error2 = errors[ , c(1, 9:12)] #local vs global

##reshape for anovas
error1.long = melt(data.frame(error1), id.vars = "subID")
error2.long = melt(data.frame(error2), id.vars = "subID")

colnames(error1.long)[2] = "Type"
colnames(error2.long)[2] = "Type"

colnames(error1.long)[3] = "Error"
colnames(error2.long)[3] = "Error"

####ERROR ANOVAS####
error1.long$Error = error1.long$Error * 100

##PURE VS SWITCH
model1 = ezANOVA(error1.long,
                within = Type,
                dv = Error,
                wid = subID,
                type = 3,
                detailed = T) #main effect of type

model1$ANOVA$MSE = model1$ANOVA$SSd/model1$ANOVA$DFd
model1$ANOVA$MSE

model1

##Post-hocs
tapply(error1.long$Error, error1.long$Type, mean) #main effect type



##Switch costs
##anova time!
#this is the overall
ezANOVA(error2.long,
        within = Type,
        dv = Error,
        wid = subID,
        type = 3,
        detailed = T)

#what about a 2x2 (cost x presentation)

#start w/ rand
error2_rand = error2[ , c(1, 3, 5)]

colnames(error2_rand)[2:3] = c("global", "local")

error2_rand$presentation = rep("rand")

error2_rand.long = melt(error2_rand,
                        measure.vars = c("global", "local"))

colnames(error2_rand.long)[3:4] = c("Cost", "Error")

#now do alt
error2_alt = error2[ , c(1, 2, 4)]

colnames(error2_alt)[2:3] = c("global", "local")

error2_alt$presentation = rep("alt")

error2_alt.long = melt(error2_alt,
                        measure.vars = c("global", "local"))

colnames(error2_alt.long)[3:4] = c("Cost", "Error")

#combine
error_costs = rbind(error2_alt.long, error2_rand.long)

ezANOVA(error_costs,
        within = .(presentation, Cost),
        dv = Error,
        wid = subID,
        type = 3,
        detailed = T)

#main effect of cost type
#marginal effect of presentation mode
#no interaction

####Error costs Post-hocs####
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