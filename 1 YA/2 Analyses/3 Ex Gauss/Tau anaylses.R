####Ex-guass analysis####
##set up
#libraries
library(ez)
library(reshape)

options(scipen = 999)

####ANALYZE TRIAL TYPES####
dat.trial = read.csv("ex_gauss_trials.csv")

model1 = ezANOVA(data = dat.trial,
        wid = ID,
        within = .(trial, parameter),
        dv = Score,
        type = 3,
        detailed = T) #everything is significant!


model1$ANOVA$MSE = model1$ANOVA$SSd/model1$ANOVA$DFd
model1$ANOVA$MSE

model1

tapply(dat.trial$Score, dat.trial$trial, mean)
tapply(dat.trial$Score, dat.trial$parameter, mean)
tapply(dat.trial$Score, list(dat.trial$parameter, dat.trial$trial), mean)

##Do some subsetting
mu = subset(dat.trial,
            dat.trial$parameter == "mu")
sigma = subset(dat.trial,
               dat.trial$parameter == "sigma")
tau = subset(dat.trial,
             dat.trial$parameter == "tau")

#mu
model1 = ezANOVA(data = mu,
                 wid = ID,
                 within = trial,
                 dv = Score,
                 type = 3,
                 detailed = T) #everything is significant!


model1$ANOVA$MSE = model1$ANOVA$SSd/model1$ANOVA$DFd
model1$ANOVA$MSE

model1

#post-hoc
posthoc1 = cast(mu, ID ~ trial, mean)

#pure
temp = t.test(posthoc1$pure, posthoc1$alt_ns, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$pure, posthoc1$alt_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$pure, posthoc1$rand_ns, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$pure, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

#alt ns
temp = t.test(posthoc1$alt_ns, posthoc1$alt_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$alt_ns, posthoc1$rand_ns, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #NS

##get pbic
pbic = subset(mu,
             mu$trial == "rand_ns" | mu$trial == "alt_ns")

ezANOVA(data = pbic,
        wid = ID,
        within = trial,
        dv = Score,
        type = 3,
        detailed = T) #everything is significant!

temp = t.test(posthoc1$alt_ns, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

##get cohen's d
mean(posthoc1$alt_ns);mean(posthoc1$rand_switch)
sd(posthoc1$alt_ns);sd(posthoc1$rand_switch)

#rand ns
temp = t.test(posthoc1$rand_ns, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$rand_ns, posthoc1$alt_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

#alt switch
temp = t.test(posthoc1$alt_switch, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #NS

##SIGMA
model1 = ezANOVA(data = sigma,
                 wid = ID,
                 within = trial,
                 dv = Score,
                 type = 3,
                 detailed = T) #everything is significant!


model1$ANOVA$MSE = model1$ANOVA$SSd/model1$ANOVA$DFd
model1$ANOVA$MSE

model1

#post-hoc
posthoc1 = cast(sigma, ID ~ trial, mean)

#pure
temp = t.test(posthoc1$pure, posthoc1$alt_ns, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$pure, posthoc1$alt_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$pure, posthoc1$rand_ns, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$pure, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

#alt ns
temp = t.test(posthoc1$alt_ns, posthoc1$alt_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$alt_ns, posthoc1$rand_ns, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #NS

temp = t.test(posthoc1$alt_ns, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

#rand ns
temp = t.test(posthoc1$rand_ns, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$rand_ns, posthoc1$alt_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

##get cohen's d
mean(posthoc1$rand_ns);mean(posthoc1$alt_switch)
sd(posthoc1$rand_ns);sd(posthoc1$alt_switch)

#alt switch
temp = t.test(posthoc1$alt_switch, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #NS

##get pbic
pbic = subset(sigma,
              sigma$trial == "alt_switch" | mu$trial == "rand_switch")

ezANOVA(data = pbic,
        wid = ID,
        within = trial,
        dv = Score,
        type = 3,
        detailed = T) #everything is significant!

####Analyze Costs####
##read in data
dat = read.csv("exgauss.csv")

summary(dat)

##Overall ANOVA
ezANOVA(data = dat,
        dv = Score,
        within = .(parameter, presentation, cost),
        wid = ID,
        type = 3,
        detailed = T) 

##local costs
dat.local = subset(dat,
                   dat$cost == "local")

ezANOVA(data = dat.local,
        dv = Score,
        within = .(parameter, presentation),
        wid = ID,
        type = 3,
        detailed = T) 

##TAU
model1 = ezANOVA(data = tau,
                 wid = ID,
                 within = trial,
                 dv = Score,
                 type = 3,
                 detailed = T) #everything is significant!


model1$ANOVA$MSE = model1$ANOVA$SSd/model1$ANOVA$DFd
model1$ANOVA$MSE

model1

#post-hoc
posthoc1 = cast(tau, ID ~ trial, mean)

#pure
temp = t.test(posthoc1$pure, posthoc1$alt_ns, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$pure, posthoc1$alt_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$pure, posthoc1$rand_ns, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

temp = t.test(posthoc1$pure, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

#alt ns
temp = t.test(posthoc1$alt_ns, posthoc1$alt_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #marginal

temp = t.test(posthoc1$alt_ns, posthoc1$rand_ns, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #.03

#get d
mean(posthoc1$alt_ns); mean(posthoc1$rand_ns)
sd(posthoc1$alt_ns); sd(posthoc1$rand_ns)

temp = t.test(posthoc1$alt_ns, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #sig

#rand ns
temp = t.test(posthoc1$rand_ns, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #marginal

temp = t.test(posthoc1$rand_ns, posthoc1$alt_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #non-sig

##get cohen's d
mean(posthoc1$rand_ns);mean(posthoc1$alt_switch)
sd(posthoc1$rand_ns);sd(posthoc1$alt_switch)

#alt switch
temp = t.test(posthoc1$alt_switch, posthoc1$rand_switch, paired = T, p.adjust.methods = "bonferroni", var.equal = T)
temp
round(temp$p.value, 3)
temp$statistic
(temp$conf.int[2] - temp$conf.int[1]) / 3.92  #NS

##get pbic
pbic = subset(tau,
              tau$trial == "alt_switch" | tau$trial == "rand_switch")

ezANOVA(data = pbic,
        wid = ID,
        within = trial,
        dv = Score,
        type = 3,
        detailed = T) #everything is significant!

####Analyze Costs####
##read in data
dat = read.csv("exgauss.csv")

summary(dat)

##Overall ANOVA
ezANOVA(data = dat,
        dv = Score,
        within = .(parameter, presentation, cost),
        wid = ID,
        type = 3,
        detailed = T) 

#subset out tau
tau2 = subset(dat,
              dat$parameter == "tau")

##overall tau

##Overall tau ANOVA
model2 = ezANOVA(data = tau2,
        dv = Score,
        within = .(presentation, cost),
        wid = ID,
        type = 3,
        detailed = T) 

model2$ANOVA$MSE = model2$ANOVA$SSd/model2$ANOVA$DFd
model2$ANOVA$MSE

model2
