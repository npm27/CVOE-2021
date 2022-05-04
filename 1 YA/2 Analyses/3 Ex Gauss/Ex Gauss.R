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

mu8 = mu
sigma8 = sigma
tau8 = tau

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

mu9 = mu
sigma9 = sigma
tau9 = tau

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

mu10 = mu
sigma10 = sigma
tau10 = tau

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

mu11 = mu
sigma11 = sigma
tau11 = tau

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

mu12 = mu
sigma12 = sigma
tau12 = tau

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

####Get the costs####
##global
#ns - p

###rand global
##start w/ pure
mu = c()
sigma = c()
tau = c()

#do pure first
for(i in unique(pure$Subject)){
  
  temp = subset(pure, pure$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu = c(mu, temp2@par[1])
  sigma = c(sigma, temp2@par[2])
  tau = c(tau, temp2@par[3])
  
}

#now rand ns
mu2 = c()
sigma2 = c()
tau2 = c()

for(i in unique(rand_ns$Subject)){
  
  temp = subset(rand_ns, rand_ns$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu2 = c(mu2, temp2@par[1])
  sigma2 = c(sigma2, temp2@par[2])
  tau2 = c(tau2, temp2@par[3])
  
}

##Get the difference
mu3 = mu2 - mu
sigma3 = sigma2 - sigma
tau3 = tau2 - tau

mu4 = mu3
sigma4 = sigma3
tau4 = tau3

##get means, uppers, lowers
CIm3 = (sd(mu3) / sqrt(length(mu3))) * 1.96
CIs3 = (sd(sigma3) / sqrt(length(mu3))) * 1.96
CIt3 = (sd(tau3) / sqrt(length(mu3))) * 1.96

parameter = c("mu", "sigma", "tau")
Average = c(mean(mu3), mean(sigma3), mean(tau3))
Upper = c(mean(mu3) + CIm3, mean(sigma3) + CIs3, mean(tau3) + CIt3)
Lower = c(mean(mu3) - CIm3, mean(sigma3) - CIs3, mean(tau3) - CIt3)
Trial_Type = rep("rand_global", times = 3)

final_rand_global = data.frame(parameter, Average, Upper, Lower, Trial_Type)

##alt global
#get the alt ns
mu2 = c()
sigma2 = c()
tau2 = c()

for(i in unique(alt_ns$Subject)){
  
  temp = subset(alt_ns, alt_ns$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu2 = c(mu2, temp2@par[1])
  sigma2 = c(sigma2, temp2@par[2])
  tau2 = c(tau2, temp2@par[3])
  
}

##Get the difference
mu3 = mu2 - mu
sigma3 = sigma2 - sigma
tau3 = tau2 - tau

mu5 = mu3
sigma5 = sigma3
tau5 = tau3

##get means, uppers, lowers
CIm3 = (sd(mu3) / sqrt(length(mu3))) * 1.96
CIs3 = (sd(sigma3) / sqrt(length(mu3))) * 1.96
CIt3 = (sd(tau3) / sqrt(length(mu3))) * 1.96

parameter = c("mu", "sigma", "tau")
Average = c(mean(mu3), mean(sigma3), mean(tau3))
Upper = c(mean(mu3) + CIm3, mean(sigma3) + CIs3, mean(tau3) + CIt3)
Lower = c(mean(mu3) - CIm3, mean(sigma3) - CIs3, mean(tau3) - CIt3)
Trial_Type = rep("alt_global", times = 3)

final_alt_global = data.frame(parameter, Average, Upper, Lower, Trial_Type)

##local
#s - ns
##rand local
mu = c()
sigma = c()
tau = c()

#do switch first
for(i in unique(rand_switch$Subject)){
  
  temp = subset(rand_switch, rand_switch$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu = c(mu, temp2@par[1])
  sigma = c(sigma, temp2@par[2])
  tau = c(tau, temp2@par[3])
  
}

#now rand ns
mu2 = c()
sigma2 = c()
tau2 = c()

for(i in unique(rand_ns$Subject)){
  
  temp = subset(rand_ns, rand_ns$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu2 = c(mu2, temp2@par[1])
  sigma2 = c(sigma2, temp2@par[2])
  tau2 = c(tau2, temp2@par[3])
  
}

##Get the difference
mu3 = mu2 - mu
sigma3 = sigma2 - sigma
tau3 = tau2 - tau

mu6 = mu3
sigma6 = sigma3
tau6 = tau3

##get means, uppers, lowers
CIm3 = (sd(mu3) / sqrt(length(mu3))) * 1.96
CIs3 = (sd(sigma3) / sqrt(length(mu3))) * 1.96
CIt3 = (sd(tau3) / sqrt(length(mu3))) * 1.96

parameter = c("mu", "sigma", "tau")
Average = c(mean(mu3), mean(sigma3), mean(tau3))
Upper = c(mean(mu3) + CIm3, mean(sigma3) + CIs3, mean(tau3) + CIt3)
Lower = c(mean(mu3) - CIm3, mean(sigma3) - CIs3, mean(tau3) - CIt3)
Trial_Type = rep("rand_local", times = 3)

final_rand_local = data.frame(parameter, Average, Upper, Lower, Trial_Type)

#alt local
mu = c()
sigma = c()
tau = c()

#do switch first
for(i in unique(alt_switch$Subject)){
  
  temp = subset(alt_switch, alt_switch$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu = c(mu, temp2@par[1])
  sigma = c(sigma, temp2@par[2])
  tau = c(tau, temp2@par[3])
  
}

#now alt ns
mu2 = c()
sigma2 = c()
tau2 = c()

for(i in unique(alt_ns$Subject)){
  
  temp = subset(alt_ns, alt_ns$Subject == i)
  temp2 = (timefit(temp$RT))
  
  mu2 = c(mu2, temp2@par[1])
  sigma2 = c(sigma2, temp2@par[2])
  tau2 = c(tau2, temp2@par[3])
  
}

##Get the difference
mu3 = mu2 - mu
sigma3 = sigma2 - sigma
tau3 = tau2 - tau

mu7 = mu3
sigma7 = sigma3
tau7 = tau3

##get means, uppers, lowers
CIm3 = (sd(mu3) / sqrt(length(mu3))) * 1.96
CIs3 = (sd(sigma3) / sqrt(length(mu3))) * 1.96
CIt3 = (sd(tau3) / sqrt(length(mu3))) * 1.96

parameter = c("mu", "sigma", "tau")
Average = c(mean(mu3), mean(sigma3), mean(tau3))
Upper = c(mean(mu3) + CIm3, mean(sigma3) + CIs3, mean(tau3) + CIt3)
Lower = c(mean(mu3) - CIm3, mean(sigma3) - CIs3, mean(tau3) - CIt3)
Trial_Type = rep("alt_local", times = 3)

final_alt_local = data.frame(parameter, Average, Upper, Lower, Trial_Type)

##Combine and write to file
final_costs = rbind(final_alt_global, final_alt_local, final_rand_global, final_rand_local)

#write.csv(final_costs, file = "Plots/ex_gauss_costs_ya2.csv", row.names = F)

####Build the dataset for the analyses####
##use 4,5,6,7
#4 = global rand
#5 = global alt
#6 = local rand
#7 = local alt

##start w/global costs
#mu
mu4 = data.frame(mu4)
mu4$ID = unique(dat2$Subject)
colnames(mu4)[1] = "Score"
mu4$presentation = rep("rand")
mu4$cost = rep("global")
mu4$parameter = rep("mu")
mu4 = mu4[ , c(2:5, 1)]

#sigma
sigma4 = data.frame(sigma4)
sigma4$ID = unique(dat2$Subject)
colnames(sigma4)[1] = "Score"
sigma4$presentation = rep("rand")
sigma4$cost = rep("global")
sigma4$parameter = rep("sigma")
sigma4 = sigma4[ , c(2:5, 1)]

#tau
tau4 = data.frame(tau4)
tau4$ID = unique(dat2$Subject)
colnames(tau4)[1] = "Score"
tau4$presentation = rep("rand")
tau4$cost = rep("global")
tau4$parameter = rep("tau")
tau4 = tau4[ , c(2:5, 1)]

final = rbind(mu4, sigma4, tau4)

##GLOBAL ALT
#mu
mu5 = data.frame(mu5)
mu5$ID = unique(dat2$Subject)
colnames(mu5)[1] = "Score"
mu5$presentation = rep("alt")
mu5$cost = rep("global")
mu5$parameter = rep("mu")
mu5 = mu5[ , c(2:5, 1)]

#sigma
sigma5 = data.frame(sigma5)
sigma5$ID = unique(dat2$Subject)
colnames(sigma5)[1] = "Score"
sigma5$presentation = rep("alt")
sigma5$cost = rep("global")
sigma5$parameter = rep("sigma")
sigma5 = sigma5[ , c(2:5, 1)]

#tau
tau5 = data.frame(tau5)
tau5$ID = unique(dat2$Subject)
colnames(tau5)[1] = "Score"
tau5$presentation = rep("alt")
tau5$cost = rep("global")
tau5$parameter = rep("tau")
tau5 = tau5[ , c(2:5, 1)]

final = rbind(final, mu5, sigma5, tau5)

##LOCAL RAND
#mu
mu6 = data.frame(mu6)
mu6$ID = unique(dat2$Subject)
colnames(mu6)[1] = "Score"
mu6$presentation = rep("rand")
mu6$cost = rep("local")
mu6$parameter = rep("mu")
mu6 = mu6[ , c(2:5, 1)]

#sigma
sigma6 = data.frame(sigma6)
sigma6$ID = unique(dat2$Subject)
colnames(sigma6)[1] = "Score"
sigma6$presentation = rep("rand")
sigma6$cost = rep("local")
sigma6$parameter = rep("sigma")
sigma6 = sigma6[ , c(2:5, 1)]

#tau
tau6 = data.frame(tau6)
tau6$ID = unique(dat2$Subject)
colnames(tau6)[1] = "Score"
tau6$presentation = rep("rand")
tau6$cost = rep("local")
tau6$parameter = rep("tau")
tau6 = tau6[ , c(2:5, 1)]

final = rbind(final, mu6, sigma6, tau6)

##local alt
#mu
mu7 = data.frame(mu7)
mu7$ID = unique(dat2$Subject)
colnames(mu7)[1] = "Score"
mu7$presentation = rep("alt")
mu7$cost = rep("local")
mu7$parameter = rep("mu")
mu7 = mu7[ , c(2:5, 1)]

#sigma
sigma7 = data.frame(sigma7)
sigma7$ID = unique(dat2$Subject)
colnames(sigma7)[1] = "Score"
sigma7$presentation = rep("alt")
sigma7$cost = rep("local")
sigma7$parameter = rep("sigma")
sigma7 = sigma7[ , c(2:5, 1)]

#tau
tau7 = data.frame(tau7)
tau7$ID = unique(dat2$Subject)
colnames(tau7)[1] = "Score"
tau7$presentation = rep("alt")
tau7$cost = rep("local")
tau7$parameter = rep("tau")
tau7 = tau7[ , c(2:5, 1)]

final = rbind(final, mu7, sigma7, tau7)

##Write to file for analyses
#write.csv(final, file = "exgauss.csv", row.names = F)

####Set up trial type analyses####
#8 = pure
#9 = alt ns
#10 = alt switch
#11 = rand ns
#12 = rand switch

###Pure
#mu
mu8 = data.frame(mu8)
mu8$ID = unique(dat2$Subject)
colnames(mu8)[1] = "Score"
mu8$trial = rep("pure")
mu8$parameter = rep("mu")
mu8 = mu8[ , c(2:4, 1)]

#sigma
sigma8 = data.frame(sigma8)
sigma8$ID = unique(dat2$Subject)
colnames(sigma8)[1] = "Score"
sigma8$trial = rep("pure")
sigma8$parameter = rep("sigma")
sigma8 = sigma8[ , c(2:4, 1)]

#tau
tau8 = data.frame(tau8)
tau8$ID = unique(dat2$Subject)
colnames(tau8)[1] = "Score"
tau8$trial = rep("pure")
tau8$parameter = rep("tau")
tau8 = tau8[ , c(2:4, 1)]

##Alt ns
#mu
mu9 = data.frame(mu9)
mu9$ID = unique(dat2$Subject)
colnames(mu9)[1] = "Score"
mu9$trial = rep("alt_ns")
mu9$parameter = rep("mu")
mu9 = mu9[ , c(2:4, 1)]

#sigma
sigma9 = data.frame(sigma9)
sigma9$ID = unique(dat2$Subject)
colnames(sigma9)[1] = "Score"
sigma9$trial = rep("alt_ns")
sigma9$parameter = rep("sigma")
sigma9 = sigma9[ , c(2:4, 1)]

#tau
tau9 = data.frame(tau9)
tau9$ID = unique(dat2$Subject)
colnames(tau9)[1] = "Score"
tau9$trial = rep("alt_ns")
tau9$parameter = rep("tau")
tau9 = tau9[ , c(2:4, 1)]

##alt switch
#mu
mu10 = data.frame(mu10)
mu10$ID = unique(dat2$Subject)
colnames(mu10)[1] = "Score"
mu10$trial = rep("alt_switch")
mu10$parameter = rep("mu")
mu10 = mu10[ , c(2:4, 1)]

#sigma
sigma10 = data.frame(sigma10)
sigma10$ID = unique(dat2$Subject)
colnames(sigma10)[1] = "Score"
sigma10$trial = rep("alt_switch")
sigma10$parameter = rep("sigma")
sigma10 = sigma10[ , c(2:4, 1)]

#tau
tau10 = data.frame(tau10)
tau10$ID = unique(dat2$Subject)
colnames(tau10)[1] = "Score"
tau10$trial = rep("alt_switch")
tau10$parameter = rep("tau")
tau10 = tau10[ , c(2:4, 1)]

##rand ns
#mu
mu11 = data.frame(mu11)
mu11$ID = unique(dat2$Subject)
colnames(mu11)[1] = "Score"
mu11$trial = rep("rand_ns")
mu11$parameter = rep("mu")
mu11 = mu11[ , c(2:4, 1)]

#sigma
sigma11 = data.frame(sigma11)
sigma11$ID = unique(dat2$Subject)
colnames(sigma11)[1] = "Score"
sigma11$trial = rep("rand_ns")
sigma11$parameter = rep("sigma")
sigma11 = sigma11[ , c(2:4, 1)]

#tau
tau11 = data.frame(tau11)
tau11$ID = unique(dat2$Subject)
colnames(tau11)[1] = "Score"
tau11$trial = rep("rand_ns")
tau11$parameter = rep("tau")
tau11 = tau11[ , c(2:4, 1)]

##rand switch
mu12 = data.frame(mu12)
mu12$ID = unique(dat2$Subject)
colnames(mu12)[1] = "Score"
mu12$trial = rep("rand_switch")
mu12$parameter = rep("mu")
mu12 = mu12[ , c(2:4, 1)]

#sigma
sigma12 = data.frame(sigma12)
sigma12$ID = unique(dat2$Subject)
colnames(sigma12)[1] = "Score"
sigma12$trial = rep("rand_switch")
sigma12$parameter = rep("sigma")
sigma12 = sigma12[ , c(2:4, 1)]

#tau
tau12 = data.frame(tau12)
tau12$ID = unique(dat2$Subject)
colnames(tau12)[1] = "Score"
tau12$trial = rep("rand_switch")
tau12$parameter = rep("tau")
tau12 = tau12[ , c(2:4, 1)]

final2 = rbind(mu8, sigma8, tau8,
               mu9, sigma9, tau9,
               mu10, sigma10, tau10,
               mu11, sigma11, tau11,
               mu12, sigma12, tau12)

#write.csv(final2, file = "ex_gauss_trials.csv", row.names = F)
