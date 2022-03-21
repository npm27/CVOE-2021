####set up####
##libraries
library(tidyverse)
library(vecsets)
library(reshape)

##read in data
keeps = read.csv("Good Subjects.csv")
dat = read.csv("data/Final_CVOE_Trimmed 11_20_21.csv")

##cut out participants we aren't using
dat2 = dat[(dat$Subject %in% keeps$Sub.ID), ]

##get Trial types
#pure
pure = subset(dat2,
              dat2$block_type == "cv" | dat2$block_type == "oe")

pure$type = rep("pure")

#Alt
alt = subset(dat2,
             dat2$block_type == "alt")

alt_switch = subset(alt,
                    alt$Switch == "Y")
alt_ns = subset(alt,
                alt$Switch == "N")

alt_switch$type = rep("alt_switch")
alt_ns$type = rep("alt_ns")

#rand
rand = subset(dat2,
              dat2$block_type == "shuf")

rand_switch = subset(rand,
                     rand$Switch == "Y")
rand_ns = subset(rand,
                 rand$Switch == "N")

rand_switch$type = rep("rand_switch")
rand_ns$type = rep("rand_ns")

##put back together
combined = rbind(pure, alt_ns, alt_switch, rand_ns, rand_switch)

#get only correct trials
RT = subset(combined,
            combined$score2 == 1)

#drop unused columns
RT = RT[ , -c(1, 3:11, 13:20)]

####compute the vincentiles####
num_vins = 6 # how many vincentiles do you want

data3 = RT %>% group_by(Subject, type) %>% 
  mutate(bin = ntile(RT,  num_vins)) %>% 
  group_by(Subject, type, bin) %>% 
  summarize(mean = mean(RT, na.rm = T))

##Okay, get the mean
means = tapply(data3$mean, list(data3$type, data3$bin), mean)

length(unique(data3$Subject))

##95%CIs
sds = tapply(data3$mean, list(data3$type, data3$bin), sd)
CI = (sds / sqrt(length(unique(data3$Subject)))) * 1.96

uppers = means + CI
lowers = means - CI

####now format and write to file for making plot####
##Means
means2 = t(means)
means2 = as.data.frame(means2)
means2$bin = rep(1:nrow(means2))

means_long = melt(means2,
                  id.vars = "bin")
colnames(means_long)[2:3] = c("Trial_Type", "Average")

##upper CI
upper2 = t(uppers)
upper2 = as.data.frame(upper2)
upper2$bin = rep(1:nrow(upper2))

upper_long = melt(upper2,
                  id.vars = "bin")
colnames(upper_long)[2:3] = c("Trial_Type", "Upper")

##Lower CI
lower2 = t(lowers)
lower2 = as.data.frame(lower2)
lower2$bin = rep(1:nrow(lower2))

lower_long = melt(lower2,
                  id.vars = "bin")
colnames(lower_long)[2:3] = c("Trial_Type", "Lower")

##combined and write to file
Final = cbind(means_long, upper_long, lower_long)
Final = Final[ , -c(4:5, 7:8)]

#write.csv(Final, file = "Plots/vincentiles.csv", row.names = F)
#write.csv(data3, file = "vin trials data.csv", row.names = F)

####Switch Costs####
bin1 = subset(data3,
              data3$bin == 1)
bin1.wide = cast(bin1, Subject ~ type, mean)

bin2 = subset(data3,
              data3$bin == 2)
bin2.wide = cast(bin2, Subject ~ type, mean)

bin3 = subset(data3,
              data3$bin == 3)
bin3.wide = cast(bin3, Subject ~ type, mean)

bin4 = subset(data3,
              data3$bin == 4)
bin4.wide = cast(bin4, Subject ~ type, mean)

bin5 = subset(data3,
              data3$bin == 5)
bin5.wide = cast(bin5, Subject ~ type, mean)

bin6 = subset(data3,
              data3$bin == 6)
bin6.wide = cast(bin6, Subject ~ type, mean)

##local costs
#s - ns
bin1.wide$rand_local = bin1.wide$rand_switch - bin1.wide$rand_ns
bin2.wide$rand_local = bin2.wide$rand_switch - bin2.wide$rand_ns
bin3.wide$rand_local = bin3.wide$rand_switch - bin3.wide$rand_ns
bin4.wide$rand_local = bin4.wide$rand_switch - bin4.wide$rand_ns
bin5.wide$rand_local = bin5.wide$rand_switch - bin5.wide$rand_ns
bin6.wide$rand_local = bin6.wide$rand_switch - bin6.wide$rand_ns

bin1.wide$alt_local = bin1.wide$alt_switch - bin1.wide$alt_ns
bin2.wide$alt_local = bin2.wide$alt_switch - bin2.wide$alt_ns
bin3.wide$alt_local = bin3.wide$alt_switch - bin3.wide$alt_ns
bin4.wide$alt_local = bin4.wide$alt_switch - bin4.wide$alt_ns
bin5.wide$alt_local = bin5.wide$alt_switch - bin5.wide$alt_ns
bin6.wide$alt_local = bin6.wide$alt_switch - bin6.wide$alt_ns

##global costs
#ns - pure
bin1.wide$rand_global = bin1.wide$rand_ns - bin1.wide$pure
bin2.wide$rand_global = bin2.wide$rand_ns - bin2.wide$pure
bin3.wide$rand_global = bin3.wide$rand_ns - bin3.wide$pure
bin4.wide$rand_global = bin4.wide$rand_ns - bin4.wide$pure
bin5.wide$rand_global = bin5.wide$rand_ns - bin5.wide$pure
bin6.wide$rand_global = bin6.wide$rand_ns - bin6.wide$pure

bin1.wide$alt_global = bin1.wide$alt_ns - bin1.wide$pure
bin2.wide$alt_global = bin2.wide$alt_ns - bin2.wide$pure
bin3.wide$alt_global = bin3.wide$alt_ns - bin3.wide$pure
bin4.wide$alt_global = bin4.wide$alt_ns - bin4.wide$pure
bin5.wide$alt_global = bin5.wide$alt_ns - bin5.wide$pure
bin6.wide$alt_global = bin6.wide$alt_ns - bin6.wide$pure

##add bin label
bin1.wide$bin = rep(1)
bin2.wide$bin = rep(2)
bin3.wide$bin = rep(3)
bin4.wide$bin = rep(4)
bin5.wide$bin = rep(5)
bin6.wide$bin = rep(6)

#now combine
costs = rbind(bin1.wide, bin2.wide, bin3.wide,
              bin4.wide, bin5.wide, bin6.wide)

costs = costs[ , -c(2:6)]
costs = data.frame(costs)

costs2 = melt(costs,
              id.vars = c("Subject", "bin"))

colnames(costs2)[3:4] = c("type", "mean")

##get mean costs and 95% CIs
##Okay, get the mean
means3 = tapply(costs2$mean, list(costs2$type, costs2$bin), mean)

length(unique(costs2$Subject))

##95%CIs
sds3 = tapply(costs2$mean, list(costs2$type, costs2$bin), sd)
CI3 = (sds3 / sqrt(length(unique(costs2$Subject)))) * 1.96

uppers3 = means3 + CI3
lowers3 = means3 - CI3

####now format and write to file for making plot####
##Means
means4 = t(means3)
means4 = as.data.frame(means4)
means4$bin = rep(1:nrow(means4))

means_long2 = melt(means4,
                   id.vars = "bin")
colnames(means_long2)[2:3] = c("Trial_Type", "Average")

##upper CI
upper4 = t(uppers3)
upper4 = as.data.frame(upper4)
upper4$bin = rep(1:nrow(upper4))

upper_long2 = melt(upper4,
                   id.vars = "bin")
colnames(upper_long2)[2:3] = c("Trial_Type", "Upper")

##Lower CI
lower4 = t(lowers3)
lower4 = as.data.frame(lower4)
lower4$bin = rep(1:nrow(lower4))

lower_long2 = melt(lower4,
                   id.vars = "bin")
colnames(lower_long2)[2:3] = c("Trial_Type", "Lower")

##combined and write to file
Final4 = cbind(means_long2, upper_long2, lower_long2)
Final4 = Final4[ , -c(4:5, 7:8)]

#write.csv(Final4, file = "Plots/vincentiles_costs.csv", row.names = F)
#write.csv(costs2, file = "ya costs analysis.csv", row.names = F)
