####setup####
library(ez)
library(reshape)
library(ggplot2)
library(Hmisc)

options(scipen = 999)

####errors####
##need percent error for pure, switch, and nonswitch
dat.errors = read.csv("Scored_10_3_21.csv")

dat.errors$error_rate = 1 - dat.errors$score2

####make a bar chart####
bar1 = ggplot(long.dat, aes(Direction, Score, fill = Task))
bar1 = bar1 +
  stat_summary(fun.y = mean, 
               geom = "bar",
               position = "dodge",
               color = "Black") +
  stat_summary(fun.data = mean_cl_normal,                
               geom = "errorbar", 
               position = position_dodge(width = 0.90),
               width = 0.2,
               color = "black") +
  scale_fill_manual("Task",
                    values = c("Jol" = "midnightblue",
                               "Recall" = "dodgerblue")) +
  cleanup +
  xlab("Direction") +
  ylab("Mean Task Performance")
#ylim(0,100)
#labs(title="All Blocks") 
bar1