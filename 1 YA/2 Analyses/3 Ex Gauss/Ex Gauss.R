####Set up####
##libraries
library(retimes)
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

####Ex-GAUSS TIME####
##Start w/ pure
pure = subset(pure,
              pure$score2 == 1)

pure = pure[ , -c(1, 3:11, 13:20)]

##need to loop over subjects and conditions
mu = c()
sigma = c()
tau = c()

for(i in unique(pure$Subject)){
  
  temp = subset(pure, pure$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu = c(mu, temp2@par[1])
  sigma = c(sigma, temp2@par[2])
  tau = c(tau, temp2@par[3])
  
}

##get means, uppers, lowers
pure_m = mean(mu)
pure_s = mean(sigma)
pure_t = mean(tau)

##alt_ns

##alt_switch

##rand_ns

##rand_switch