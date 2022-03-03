library(ez)
library(readxl)
library(reshape)

RTs = as.data.frame(RTs)

RTs = read_xlsx("Bar Chart Analyses.xlsx", sheet = "RTs")
errors = read_xlsx("Bar Chart Analyses.xlsx", sheet = "ERRORS")

RTs = as.data.frame(RTs)

RTs_trial = RTs[ , c(1, 4:8, 13)]
RTs_cost = RTs[ , c(1, 9:13)]

RTs1 = melt(RTs_trial,
            id = c("subID", "Group"))
RTs2 = melt(RTs_cost,
            id = c("subID", "Group"))


colnames(RTs1)[3:4] = c("type", "score")
colnames(RTs2)[3:4] = c("type", "score")

ezANOVA(RTs1,
        dv = score,
        wid = subID,
        within = type,
        between = Group,
        type = 3,
        detailed = F)

tapply(RTs1$score, RTs1$Group, mean)
tapply(RTs1$score, RTs1$type, mean)

tapply(RTs1$score, list(RTs1$type, RTs1$Group), mean)

ezANOVA(RTs2,
        dv = score,
        wid = subID,
        within = type,
        between = Group,
        type = 3,
        detailed = F)

tapply(RTs2$score, RTs2$Group, mean)
tapply(RTs2$score, RTs2$type, mean)

tapply(RTs2$score, list(RTs2$type, RTs2$Group), mean)

#post hoc tests
YA = subset(RTs1, RTs1$Group == "YA")
MCI = subset(RTs1, RTs1$Group == "MCI")
HA = subset(RTs1, RTs1$Group == "Healthy")

YA2 = cast(YA, subID ~ type, mean)
MCI2 = cast(MCI, subID ~ type, mean)
HA2 = cast(HA, subID ~ type, mean)

#Rand vs predictive
t.test(YA2$switch_altrun_rt, YA2$switch_rand_rt) #ns
t.test(HA2$switch_altrun_rt, HA2$switch_rand_rt) #ns
t.test(MCI2$switch_altrun_rt, MCI2$switch_rand_rt) #ns

t.test(YA2$non_altrun_rt, YA2$non_rand_rt) #ns
t.test(HA2$non_altrun_rt, HA2$non_rand_rt) #ns
t.test(MCI2$non_altrun_rt, MCI2$non_rand_rt) #ns

#No differences between random switch and non-switch for each group

#now do costs
YA = subset(RTs2, RTs2$Group == "YA")
MCI = subset(RTs2, RTs2$Group == "MCI")
HA = subset(RTs2, RTs2$Group == "Healthy")

YA2 = cast(YA, subID ~ type, mean)
MCI2 = cast(MCI, subID ~ type, mean)
HA2 = cast(HA, subID ~ type, mean)

t.test(YA2$global_cost_alt_RT, YA2$global_cost_rand_RT) #ns
t.test(HA2$global_cost_alt_RT, HA2$global_cost_rand_RT) #ns
t.test(MCI2$global_cost_alt_RT, MCI2$global_cost_rand_RT) #ns

t.test(YA2$local_switch_cost_alt_RT, YA2$local_switch_cost_rand_RT) 
t.test(HA2$local_switch_cost_alt_RT, HA2$local_switch_cost_rand_RT) 
t.test(MCI2$local_switch_cost_alt_RT, MCI2$local_switch_cost_rand_RT) 

##errors
errors = as.data.frame(errors)

errors_trial = errors[ , c(1, 4:8, 13)]
errors_cost = errors[ , c(1, 9:13)]

errors1 = melt(errors_trial,
            id = c("subID", "Group"))
errors2 = melt(errors_cost,
            id = c("subID", "Group"))


colnames(errors1)[3:4] = c("type", "score")
colnames(errors2)[3:4] = c("type", "score")

ezANOVA(errors1,
        dv = score,
        wid = subID,
        within = type,
        between = Group,
        type = 3,
        detailed = F)

tapply(errors1$score, errors1$Group, mean)
tapply(errors1$score, errors1$type, mean)

tapply(errors1$score, list(errors1$type, errors1$Group), mean)

ezANOVA(errors2,
        dv = score,
        wid = subID,
        within = type,
        between = Group,
        type = 3,
        detailed = F)

tapply(errors2$score, errors2$Group, mean)
tapply(errors2$score, errors2$type, mean)

tapply(errors2$score, list(errors2$type, errors2$Group), mean)

#post hoc tests
YA = subset(errors1, errors1$Group == "YA")
MCI = subset(errors1, errors1$Group == "MCI")
HA = subset(errors1, errors1$Group == "Healthy")

YA2 = cast(YA, subID ~ type, mean)
MCI2 = cast(MCI, subID ~ type, mean)
HA2 = cast(HA, subID ~ type, mean)

t.test(YA2$alt_switch_errors, YA2$rand_switch_errors) #ns
t.test(HA2$alt_switch_errors, HA2$rand_switch_errors) #ns
t.test(MCI2$alt_switch_errors, MCI2$rand_switch_errors) #ns

t.test(YA2$alt_non_switch_errors, YA2$rand_non_switch_errors) #ns
t.test(HA2$alt_non_switch_errors, HA2$rand_non_switch_errors) #ns
t.test(MCI2$alt_non_switch_errors, MCI2$rand_non_switch_errors) #ns

##now do costs
YA = subset(errors2, errors2$Group == "YA")
MCI = subset(errors2, errors2$Group == "MCI")
HA = subset(errors2, errors2$Group == "Healthy")

YA2 = cast(YA, subID ~ type, mean)
MCI2 = cast(MCI, subID ~ type, mean)
HA2 = cast(HA, subID ~ type, mean)

t.test(YA2$global_cost_alt, YA2$global_cost_rand) #ns
t.test(HA2$global_cost_alt, HA2$global_cost_rand) #ns
t.test(MCI2$global_cost_alt, MCI2$global_cost_rand) #ns

t.test(YA2$local_switch_cost_alt, YA2$local_switch_cost_rand) 
t.test(HA2$local_switch_cost_alt, HA2$local_switch_cost_rand) 
t.test(MCI2$local_switch_cost_alt, MCI2$local_switch_cost_rand)
