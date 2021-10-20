####set up####
##libraries
library(tidyverse)
library(vecsets)

##read in data
keeps = read.csv("Good Subjects.csv")
dat = read.csv("data/Final_CVOE_Trimmed 10_3_21.csv")

##cut out participants we aren't using
dat2 = dat[(dat$Subject %in% keeps$Sub.ID), ]

#get only correct trials
RT = subset(dat2,
            dat2$score2 == 1)

##Drop unused columns
RT = RT[ , -c(19, 20)]

##Now subset into pure, switch_rand, switch_alt, ns_rand, ns_alt
#need to add codings and then stick it back together
table(RT$block_type)

pure = subset(RT,
              RT$block_type == "cv" | RT$block_type == "oe")
