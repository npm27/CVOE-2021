####set up####
##libraries
library(tidyverse)
library(vecsets)
library(reshape)

##read in data
keeps = read.csv("Good Subjects.csv")
dat = read.csv("data/Final_CVOE_Trimmed 10_25_21.csv")

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

#write.csv(Final, file = "vincentiles.csv", row.names = F)
