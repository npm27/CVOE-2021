##Load data
combined = read.csv("Final_CVOE_Trimmed 11_20_21.csv")

combined = na.omit(combined)

rt = subset(combined,
            combined$score2 == 1)

####check descriptives####
##mean rts by group
tapply(combined$RT,
              combined$block_type, mean)

##mean percent error by block type
tapply((1 - combined$score2) * 100,
             combined$block_type, mean)

##differences within switch groups
##make a switch group subset
yes.switch = subset(combined,
                    combined$Switch == "Y")
no.switch = subset(combined,
                   combined$Switch == "N")

yes.switch.rt = subset(rt,
                    rt$Switch == "Y")
no.switch.rt = subset(rt,
                   rt$Switch == "N")

tapply(yes.switch$RT,
       yes.switch$block_type, mean)
tapply(no.switch$RT,
       no.switch$block_type, mean)

tapply(yes.switch$score2 * 100,
       yes.switch$block_type, mean)
tapply(no.switch$score2 * 100,
       no.switch$block_type, mean)

##congruency
tapply(combined$RT,
       list(combined$block_type, combined$Congruent), mean)
tapply(combined$score,
       list(combined$block_type, combined$Congruent), mean)

####check by subject####
##overall
m1 = tapply(combined$score2,
       list(combined$block_type, combined$Subject), mean)

pure_cv_m = list(m1[2, ])
pure_oe_m = list(m1[3, ])
alt_run_m = list(m1[1, ])
shuff_m = list(m1[4, ])

##Switch
m2 = tapply(yes.switch$score2,
       list(yes.switch$block_type, yes.switch$Subject), mean)

switch_alt_run_m = list(m2[1, ])
switch_shuff_m = list(m2[2, ])

##non-switch
m3 = tapply(no.switch$score2,
       list(no.switch$block_type, no.switch$Subject), mean)

no_switch_alt_run_m = list(m3[1, ])
no_switch_shuff_m = list(m3[2, ])

##put all the output into a dataframe
#first need to get the sub ID. I could type it all out, but that's going to be too time consuming once this gets big

#so, lets try to make a table of subject numbers then grab the index.
library(data.table)

d = table(combined$Subject)
d = as.data.frame(d)
d = setDT(d, keep.rownames = TRUE)[]

#subID = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 33, 36)
subID = d$Var1 #This does the same thing as the line above it

#make the thing!
output = data.frame(subID, pure_cv_m, pure_oe_m, alt_run_m, 
                     shuff_m, switch_alt_run_m, switch_shuff_m, 
                     no_switch_alt_run_m,
                     no_switch_shuff_m)

#name the columns!
colnames(output)[2:9] = c("pure_cv_m", "pure_oe_m", "altrun_m",
                           "shuff_m", "switch_altrun_m",  "switch_shuff_m",
                            "no_switch_altrun_m",
                           "no_switch_shuff_m")

#write.csv(output, file = "CVOE_Means_10_3_21.csv", row.names = FALSE)

##get the sds
sd1 = tapply(combined$score2,
            list(combined$block_type, combined$Subject), sd)

pure_cv_sd = list(sd1[2, ])
pure_oe_sd = list(sd1[3, ])

sds = data.frame(subID, pure_cv_sd, pure_oe_sd)

colnames(sds)[2:3] = c("Pure_cv", "pure_oe")

#write.csv(sds, file = "CVOE_PURE_SDS.csv", row.names = FALSE)

####set up output####
##mean errors
mean_cv_errors = 1 - output$pure_cv_m
mean_oe_errors = 1 - output$pure_oe_m
mean_alt_errors = 1 - output$altrun_m
mean_rand_errors = 1 - output$shuff_m
alt_switch_errors = 1 - output$switch_altrun_m
alt_non_switch_errors = 1 - output$no_switch_altrun_m
rand_switch_errors = 1 - output$switch_shuff_m
rand_non_switch_errors = 1 - output$no_switch_shuff_m

pure_block_errors = (mean_cv_errors + mean_oe_errors) / 2

##global switch cost
global_cost_alt = alt_non_switch_errors - pure_block_errors
global_cost_rand = rand_non_switch_errors - pure_block_errors

##local switch cost
local_switch_cost_alt = alt_switch_errors - alt_non_switch_errors
local_switch_cost_rand = rand_switch_errors - rand_non_switch_errors

##put it all together
output_errors = data.frame(subID, mean_cv_errors, mean_oe_errors, pure_block_errors,
                           alt_switch_errors, alt_non_switch_errors, rand_switch_errors, rand_non_switch_errors,
                           global_cost_alt, global_cost_rand,
                           local_switch_cost_alt, local_switch_cost_rand)

#write.csv(output_errors, file = "Output Mean Errors 11_20_21.csv", row.names = FALSE)

##and z the error rates
output_errors$z_cv = scale(output_errors$mean_cv_errors)
output_errors$z_oe = scale(output_errors$mean_oe_errors)
output_errors$z_alt_switch = scale(output_errors$alt_switch_errors)
output_errors$z_alt_ns = scale(output_errors$alt_non_switch_errors)
output_errors$z_rand_switch = scale(output_errors$rand_switch_errors)
output_errors$z_rand_ns = scale(output_errors$rand_non_switch_errors)

#remove participant
output_errors = subset(output_errors,
                       output_errors$subID != 36)

##remove anyone more (or less) than three sds across trial type
cleaned = subset(output_errors,
                 output_errors$z_cv < 3 & output_errors$z_oe < 3 & output_errors$z_alt_switch < 3 &
                         output_errors$z_alt_ns < 3 & output_errors$z_rand_switch < 3 & output_errors$z_rand_ns < 3)

#write.csv(cleaned, file = "Output Mean Errors cleaned 12_8_21.csv", row.names = FALSE)

##clear the environment
rm(list = ls())

####RTs####
##read in trimmed data
trimmed = read.csv("Final_CVOE_Trimmed 11_20_21.csv")
summary(trimmed)

rt = subset(trimmed, #get only the correct responses for RTs
            trimmed$score2 == 1)

####set up data####
##overall
rt1 = tapply(rt$RT,
             list(rt$block_type, rt$Subject), mean)

pure_cv_rt = list(rt1[2, ])
pure_oe_rt = list(rt1[3, ])
alt_run_rt = list(rt1[1, ])
shuff_rt = list(rt1[4, ])

##switch
yes.switch.rt = subset(rt,
                       rt$Switch == "Y")
no.switch.rt = subset(rt,
                      rt$Switch == "N")

rt2 = tapply(yes.switch.rt$RT,
             list(yes.switch.rt$block_type, yes.switch.rt$Subject), mean)

switch_alt_run_rt = list(rt2[1, ])
switch_shuff_rt = list(rt2[2, ])

##non-switch
rt3 = tapply(no.switch.rt$RT,
             list(no.switch.rt$block_type, no.switch.rt$Subject), mean)

no_switch_alt_run_rt = list(rt3[1, ])
no_switch_shuff_rt = list(rt3[2, ])

#table(dat)

##get all the rt stuff into a dataframe
#subID = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 33, 36)

library(data.table)

d = table(trimmed$Subject)
d = as.data.frame(d)
d = setDT(d, keep.rownames = TRUE)[]

subID = d$Var1

output2 = data.frame(subID, pure_cv_rt, pure_oe_rt, alt_run_rt, 
                    shuff_rt, switch_alt_run_rt,
                    switch_shuff_rt, no_switch_alt_run_rt,
                    no_switch_shuff_rt)


colnames(output2)[2:9] = c("pure_cv_rt", "pure_oe_rt", "altrun_rt",
                           "shuff_rt", "switch_altrun_rt",
                           "switch_shuff_rt", "no_switch_altrun_rt",
                           "no_switch_shuff_rt")

##get cv, oe, alt, and shuff
mean_cv_rt = output2$pure_cv_rt
mean_oe_rt = output2$pure_oe_rt
mean_alt_rt = output2$altrun_rt
mean_shuff_rt = output2$shuff_rt

##switch and non switch
##altrun
switch_altrun_rt = output2$switch_altrun_rt
non_altrun_rt = output2$no_switch_altrun_rt

##shuff
switch_rand_rt = output2$switch_shuff_rt
non_rand_rt = output2$no_switch_shuff_rt

##get pure, local, and global
pure_RT= (output2$pure_cv_rt + output2$pure_oe_rt) / 2

##global switch cost
global_cost_alt_RT = output2$no_switch_altrun_rt - pure_RT
global_cost_rand_RT = output2$no_switch_shuff_rt - pure_RT

##local switch cost
local_switch_cost_alt_RT = output2$switch_altrun_rt - output2$no_switch_altrun_rt
local_switch_cost_rand_RT = output2$switch_shuff_rt - output2$no_switch_shuff_rt

##put everything together
output_RT = data.frame(subID, mean_cv_rt, mean_oe_rt, pure_RT,
                       switch_altrun_rt, non_altrun_rt,
                       switch_rand_rt, non_rand_rt,
                       global_cost_alt_RT, global_cost_rand_RT,
                       local_switch_cost_alt_RT, local_switch_cost_rand_RT)

#get list of subjects to remove
keeps = read.csv("Output Mean Errors cleaned 12_8_21.csv")

output_RT2 = output_RT[(output_RT$subID %in% keeps$subID), ]

#write.csv(output_RT2, file = "Output RTs 11_20_21.csv", row.names = FALSE)

####Zscore things####

##clear the environment
rm(list = ls())

##read in trimmed data
trimmed = read.csv("Final_CVOE_Trimmed 10_3_21.csv")
summary(trimmed)

rt = subset(trimmed, #get only the correct responses for RTs
            trimmed$score2 == 1)

####set up data####
##overall
rt1 = tapply(rt$zRT,
             list(rt$block_type, rt$Subject), mean)

pure_cv_rt = list(rt1[2, ])
pure_oe_rt = list(rt1[3, ])
alt_run_rt = list(rt1[1, ])
shuff_rt = list(rt1[4, ])

##switch
yes.switch.rt = subset(rt,
                       rt$Switch == "Y")
no.switch.rt = subset(rt,
                      rt$Switch == "N")

rt2 = tapply(yes.switch.rt$zRT,
             list(yes.switch.rt$block_type, yes.switch.rt$Subject), mean)

switch_alt_run_rt = list(rt2[1, ])
switch_shuff_rt = list(rt2[2, ])

##non-switch
rt3 = tapply(no.switch.rt$zRT,
             list(no.switch.rt$block_type, no.switch.rt$Subject), mean)

no_switch_alt_run_rt = list(rt3[1, ])
no_switch_shuff_rt = list(rt3[2, ])

#table(dat)

##get all the rt stuff into a dataframe
#subID = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 33, 36)

library(data.table)

d = table(trimmed$Subject)
d = as.data.frame(d)
d = setDT(d, keep.rownames = TRUE)[]

subID = d$Var1

output2 = data.frame(subID, pure_cv_rt, pure_oe_rt, alt_run_rt, 
                     shuff_rt, switch_alt_run_rt,
                     switch_shuff_rt, no_switch_alt_run_rt,
                     no_switch_shuff_rt)


colnames(output2)[2:9] = c("pure_cv_zrt", "pure_oe_zrt", "altrun_zrt",
                           "shuff_zrt", "switch_altrun_zrt",
                           "switch_shuff_zrt", "no_switch_altrun_zrt",
                           "no_switch_shuff_zrt")

##get cv, oe, alt, and shuff
mean_cv_zrt = output2$pure_cv_zrt
mean_oe_zrt = output2$pure_oe_zrt
mean_alt_zrt = output2$altrun_zrt
mean_shuff_zrt = output2$shuff_zrt

##switch and non switch
##altrun
switch_altrun_zrt = output2$switch_altrun_zrt
non_altrun_zrt = output2$no_switch_altrun_zrt

##shuff
switch_rand_zrt = output2$switch_shuff_zrt
non_rand_zrt = output2$no_switch_shuff_zrt

##get pure, local, and global
pure_zRT = (output2$pure_cv_zrt + output2$pure_oe_zrt) / 2

##global switch cost
global_cost_alt_zRT = output2$no_switch_altrun_zrt - pure_zRT
global_cost_rand_zRT = output2$no_switch_shuff_zrt - pure_zRT

##local switch cost
local_switch_cost_alt_zRT = output2$switch_altrun_zrt - output2$no_switch_altrun_zrt
local_switch_cost_rand_zRT = output2$switch_shuff_zrt - output2$no_switch_shuff_zrt

##put everything together
output_zRT = data.frame(subID, mean_cv_zrt, mean_oe_zrt, pure_zRT,
                       switch_altrun_zrt, non_altrun_zrt,
                       switch_rand_zrt, non_rand_zrt,
                       global_cost_alt_zRT, global_cost_rand_zRT,
                       local_switch_cost_alt_zRT, local_switch_cost_rand_zRT)

#write.csv(output_zRT, file = "Output zRTs 10_3_21.csv", row.names = FALSE)
