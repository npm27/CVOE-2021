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

#set up for t-tests
errors_ph = cast(error1.long, subID ~ Type, mean)

###run the t-tests
##pure
#pure vs alt switch
temp = t.test(errors_ph$pure_block_errors, errors_ph$alt_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #SIG, t = 6.28

#pure vs alt ns
temp = t.test(errors_ph$pure_block_errors, errors_ph$alt_non_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #NS t = .610

#pure vs rand switch
temp = t.test(errors_ph$pure_block_errors, errors_ph$rand_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #SIG t = 4.65

#pure vs rand ns
temp = t.test(errors_ph$pure_block_errors, errors_ph$rand_non_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #NS t = .0703

##pbic #need cols 1, 2, 6
pbic1 = errors_ph[ , c(1, 2)]
pbic1$trial = rep("pure")

colnames(pbic1)[2] = "error"

pbic2 = errors_ph[ , c(1, 6)]
pbic2$trial = rep("rand_ns")

colnames(pbic2)[2] = "error"

pbic3 = rbind(pbic1, pbic2)

model_pbic = ezANOVA(pbic3,
                     dv = error,
                     wid = subID,
                     within = trial,
                     detailed = T,
                     type = 3)
model_pbic

#pure groups differ from switch trials but not non-switch (ns) trials

##alt_switch
#alt_switch vs alt_ns
temp = t.test(errors_ph$alt_switch_errors, errors_ph$alt_non_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #SIG, t = 5.87

#alt_switch vs rand switch
temp = t.test(errors_ph$alt_switch_errors, errors_ph$rand_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #marginal, p = .06

##get means and sds for d
mean(errors_ph$alt_switch_errors); mean(errors_ph$rand_switch_errors)
sd(errors_ph$alt_switch_errors); sd(errors_ph$rand_switch_errors)

##pbic #need cols 1, 3, 5
pbic1 = errors_ph[ , c(1, 3)]
pbic1$pres = rep("alt")

colnames(pbic1)[2] = "cost"

pbic2 = errors_ph[ , c(1, 5)]
pbic2$pres = rep("rand")

colnames(pbic2)[2] = "cost"

pbic3 = rbind(pbic1, pbic2)

model_pbic = ezANOVA(pbic3,
                     dv = cost,
                     wid = subID,
                     within = pres,
                     detailed = T,
                     type = 3)
model_pbic

#alt_switch vs rand ns
temp = t.test(errors_ph$alt_switch_errors, errors_ph$rand_non_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #SIG, t = 6.72

##alt_ns
#alt_ns vs rand switch
temp = t.test(errors_ph$alt_non_switch_errors, errors_ph$rand_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #SIG, t = 3.63

##get d
mean(errors_ph$alt_non_switch_errors); mean(errors_ph$rand_switch_errors)
sd(errors_ph$alt_non_switch_errors); sd(errors_ph$rand_switch_errors)

#alt_ns vs rand_ns
temp = t.test(errors_ph$alt_non_switch_errors, errors_ph$rand_non_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #NS

##rand_switch
#Rand switch vs rand ns
temp = t.test(errors_ph$rand_switch_errors, errors_ph$rand_non_switch_errors, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #Sig, t = 6.10

####Switch costs - Errors####
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

error_costs$Error = error_costs$Error * 100

model2 = ezANOVA(error_costs,
                within = .(presentation, Cost),
                dv = Error,
                wid = subID,
                type = 3,
                detailed = T)

model2$ANOVA$MSE = model2$ANOVA$SSd/model2$ANOVA$DFd
model2$ANOVA$MSE

model2

#main effect of cost type
#marginal effect of presentation mode
#no interaction

####Error costs Post-hocs####
tapply(error_costs$Error, error_costs$presentation, mean)
tapply(error_costs$Error, error_costs$Cost, mean)

tapply(error_costs$Error, list(error_costs$presentation, error_costs$Cost), mean) #interaction

#post hoc here
error_costs_ph = cast(error_costs, subID ~ presentation, mean)
mean(error_costs_ph$alt)
mean(error_costs_ph$rand)

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
model3 = ezANOVA(RTs1.long,
                within = Type,
                dv = RTs,
                wid = subID,
                type = 3,
                detailed = T)

model3$ANOVA$MSE = model3$ANOVA$SSd/model3$ANOVA$DFd
model3$ANOVA$MSE

model3

##Post-hocs
tapply(RTs1.long$RTs, RTs1.long$Type, mean) #main effect type

##run the t-tests
#set up for t-tests
Rts_ph = cast(RTs1.long, subID ~ Type, mean)

##pure
#pure vs alt switch
temp = t.test(Rts_ph$pure_RT, Rts_ph$switch_altrun_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #SIG

#pure vs alt ns
temp = t.test(Rts_ph$pure_RT, Rts_ph$non_altrun_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92

#pure vs rand switch
temp = t.test(Rts_ph$pure_RT, Rts_ph$switch_rand_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92

#pure vs rand ns
temp = t.test(Rts_ph$pure_RT, Rts_ph$non_rand_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92

###Alt switch error
temp = t.test(Rts_ph$switch_altrun_rt, Rts_ph$non_altrun_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92

temp = t.test(Rts_ph$switch_altrun_rt, Rts_ph$switch_rand_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92 #non-sig

temp = t.test(Rts_ph$switch_altrun_rt, Rts_ph$non_rand_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92

##alt non-switch
temp = t.test(Rts_ph$non_altrun_rt, Rts_ph$switch_rand_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92

temp = t.test(Rts_ph$non_altrun_rt, Rts_ph$non_rand_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92

mean(Rts_ph$non_altrun_rt); mean(Rts_ph$non_rand_rt)
sd(Rts_ph$non_altrun_rt); sd(Rts_ph$non_rand_rt)

##rand switch
temp = t.test(Rts_ph$switch_rand_rt, Rts_ph$non_rand_rt, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92

#get pbic
pbic1 = Rts_ph[ , c(1, 3)]
pbic1$pres = rep("alt")

colnames(pbic1)[2] = "cost"

pbic2 = Rts_ph[ , c(1, 5)]
pbic2$pres = rep("rand")

colnames(pbic2)[2] = "cost"

pbic3 = rbind(pbic1, pbic2)

model_pbic = ezANOVA(pbic3,
                     dv = cost,
                     wid = subID,
                     within = pres,
                     detailed = T,
                     type = 3)
model_pbic

##Switch costs
##anova time!
#start w/ rand
RTs2_rand = RTs2[ , c(1, 3, 5)]

colnames(RTs2_rand)[2:3] = c("global", "local")

RTs2_rand$presentation = rep("rand")

RTs2_rand.long = melt(RTs2_rand,
                        measure.vars = c("global", "local"))

colnames(RTs2_rand.long)[3:4] = c("Cost", "RTs")

#now do alt
RTs2_alt = RTs2[ , c(1, 2, 4)]

colnames(RTs2_alt)[2:3] = c("global", "local")

RTs2_alt$presentation = rep("alt")

RTs2_alt.long = melt(RTs2_alt,
                       measure.vars = c("global", "local"))

colnames(RTs2_alt.long)[3:4] = c("Cost", "RTs")

#combine
RTs_costs = rbind(RTs2_alt.long, RTs2_rand.long)

model4 = ezANOVA(RTs_costs,
                 within = .(presentation, Cost),
                 dv = RTs,
                 wid = subID,
                 type = 3,
                 detailed = T)

model4$ANOVA$MSE = model4$ANOVA$SSd/model4$ANOVA$DFd
model4$ANOVA$MSE

model4

##t-tests here