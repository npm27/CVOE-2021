####Set up####
dat = read.csv("1 Initial/corrected pre-trimmed.csv")

#fix the order

#dat = dat[ , -1]

####Z-RTs#####
##get correct trials only

id = unique(dat$Subject)

temp2 = c()

#get means
for(i in unique(id)){
  
  print(i)
  
  temp = subset(dat,
                dat$Subject == i)
  
  m = mean(temp$RT)
  print(m)
  
  m2 = rep(m, times = nrow(temp))
  print(nrow(temp))
  
  temp2 = c(temp2, m2)
  
}

dat$mean = temp2

temp3 = c()

#get sds
for(i in unique(id)){
  
  print(i)
  
  temp = subset(dat,
                dat$Subject == i)
  
  s = sd(temp$RT)
  print(s)
  
  s2 = rep(s, times = nrow(temp))
  print(nrow(temp))
  
  temp3 = c(temp3, s2)
  
}

dat$sds = temp3

#get the trial difference
dat$diff = (dat$RT - dat$mean)

#z-score!
dat$z = dat$diff/dat$sds

##remove anything above/below 3
dat.trimmed = subset(dat,
                     dat$z < 3)
dat.trimmed2 = subset(dat.trimmed,
                      dat.trimmed$z > -3)

##what percent of the data is this?
removed = nrow(dat) - nrow(dat.trimmed2)
p = removed / nrow(dat) * 100
p

#write to csv
#write.csv(dat.trimmed2, file = "Final_CVOE_Trimmed 11_20_21.csv", row.names = FALSE)
