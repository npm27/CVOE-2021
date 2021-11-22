####Set up####
##libraries
library(retimes)
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

####Ex-GAUSS TIME####
##Start w/ pure
pure = subset(pure,
              pure$score2 == 1)

pure = pure[ , -c(1, 3:11, 13:20)]

##need to loop over subjects
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
CIm = (sd(mu) / sqrt(length(mu))) * 1.96
CIs = (sd(sigma) / sqrt(length(mu))) * 1.96
CIt = (sd(tau) / sqrt(length(mu))) * 1.96

#combine
parameter = c("mu", "sigma", "tau")
Average = c(mean(mu), mean(sigma), mean(tau))
Upper = c(mean(mu) + CIm, mean(sigma) + CIs, mean(tau) + CIt)
Lower = c(mean(mu) - CIm, mean(sigma) - CIs, mean(tau) - CIt)
Trial_Type = rep("pure", times = 3)

final_pure = data.frame(parameter, Average, Upper, Lower, Trial_Type)

##alt_ns
alt_ns = subset(alt_ns,
              alt_ns$score2 == 1)

alt_ns = alt_ns[ , -c(1, 3:11, 13:20)]

##need to loop over subjects
mu = c()
sigma = c()
tau = c()

for(i in unique(alt_ns$Subject)){
  
  temp = subset(alt_ns, alt_ns$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu = c(mu, temp2@par[1])
  sigma = c(sigma, temp2@par[2])
  tau = c(tau, temp2@par[3])
  
}

##get means, uppers, lowers
CIm = (sd(mu) / sqrt(length(mu))) * 1.96
CIs = (sd(sigma) / sqrt(length(mu))) * 1.96
CIt = (sd(tau) / sqrt(length(mu))) * 1.96

#combine
parameter = c("mu", "sigma", "tau")
Average = c(mean(mu), mean(sigma), mean(tau))
Upper = c(mean(mu) + CIm, mean(sigma) + CIs, mean(tau) + CIt)
Lower = c(mean(mu) - CIm, mean(sigma) - CIs, mean(tau) - CIt)
Trial_Type = rep("Alt_ns", times = 3)

final_alt_ns = data.frame(parameter, Average, Upper, Lower, Trial_Type)

##alt_switch
alt_switch = subset(alt_switch,
              alt_switch$score2 == 1)

alt_switch = alt_switch[ , -c(1, 3:11, 13:20)]

##need to loop over subjects
mu = c()
sigma = c()
tau = c()

for(i in unique(alt_switch$Subject)){
  
  temp = subset(alt_switch, alt_switch$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu = c(mu, temp2@par[1])
  sigma = c(sigma, temp2@par[2])
  tau = c(tau, temp2@par[3])
  
}

##get means, uppers, lowers
CIm = (sd(mu) / sqrt(length(mu))) * 1.96
CIs = (sd(sigma) / sqrt(length(mu))) * 1.96
CIt = (sd(tau) / sqrt(length(mu))) * 1.96

#combine
parameter = c("mu", "sigma", "tau")
Average = c(mean(mu), mean(sigma), mean(tau))
Upper = c(mean(mu) + CIm, mean(sigma) + CIs, mean(tau) + CIt)
Lower = c(mean(mu) - CIm, mean(sigma) - CIs, mean(tau) - CIt)
Trial_Type = rep("alt_switch", times = 3)

final_alt_switch = data.frame(parameter, Average, Upper, Lower, Trial_Type)

##rand_ns
rand_ns = subset(rand_ns,
              rand_ns$score2 == 1)

rand_ns = rand_ns[ , -c(1, 3:11, 13:20)]

##need to loop over subjects
mu = c()
sigma = c()
tau = c()

for(i in unique(rand_ns$Subject)){
  
  temp = subset(rand_ns, rand_ns$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu = c(mu, temp2@par[1])
  sigma = c(sigma, temp2@par[2])
  tau = c(tau, temp2@par[3])
  
}

##get means, uppers, lowers
CIm = (sd(mu) / sqrt(length(mu))) * 1.96
CIs = (sd(sigma) / sqrt(length(mu))) * 1.96
CIt = (sd(tau) / sqrt(length(mu))) * 1.96

#combine
parameter = c("mu", "sigma", "tau")
Average = c(mean(mu), mean(sigma), mean(tau))
Upper = c(mean(mu) + CIm, mean(sigma) + CIs, mean(tau) + CIt)
Lower = c(mean(mu) - CIm, mean(sigma) - CIs, mean(tau) - CIt)
Trial_Type = rep("rand_ns", times = 3)

final_rand_ns = data.frame(parameter, Average, Upper, Lower, Trial_Type)

##rand_switch
rand_switch = subset(rand_switch,
              rand_switch$score2 == 1)

rand_switch = rand_switch[ , -c(1, 3:11, 13:20)]

##need to loop over subjects
mu = c()
sigma = c()
tau = c()

for(i in unique(rand_switch$Subject)){
  
  temp = subset(rand_switch, rand_switch$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu = c(mu, temp2@par[1])
  sigma = c(sigma, temp2@par[2])
  tau = c(tau, temp2@par[3])
  
}

##get means, uppers, lowers
CIm = (sd(mu) / sqrt(length(mu))) * 1.96
CIs = (sd(sigma) / sqrt(length(mu))) * 1.96
CIt = (sd(tau) / sqrt(length(mu))) * 1.96

#combine
parameter = c("mu", "sigma", "tau")
Average = c(mean(mu), mean(sigma), mean(tau))
Upper = c(mean(mu) + CIm, mean(sigma) + CIs, mean(tau) + CIt)
Lower = c(mean(mu) - CIm, mean(sigma) - CIs, mean(tau) - CIt)
Trial_Type = rep("rand_switch", times = 3)

final_rand_switch = data.frame(parameter, Average, Upper, Lower, Trial_Type)

##Combine and write to file
final = rbind(final_pure, final_alt_ns, final_alt_switch, final_rand_ns, final_rand_switch)
#write.csv(final, file = "Plots/ex_gauss_ya.csv", row.names = F)